class SurveysController < ApplicationController
  before_action :load_survey_from_public_url, only: [:show, :answer]
  before_action :load_survey_from_private_url, only: [:destroy]

  def index
    @surveys = current_user.surveys.ordered.eager.last(50)
  end

  def show
    respond_to do |format|
      format.html

      format.json do
        survey_json = {
          url: @survey.public_url,
          title: @survey.title,
          created_at: @survey.created_at.iso8601,
        }

        if can_see_results?(@survey)
          survey_json.merge!({
            total_answers: @survey.total_answers,
            choices: @survey.choices.map do |choice|
              choice_json = {
                id: choice.id,
                body: choice.body,
                answers: choice.answers.count,
              }

              if choice.free_form?
                choice_json.merge!(
                  comments: choice.answers.with_comment.pluck(:comment)
                )
              end

              choice_json
            end
          })
        end

        render json: survey_json
      end

    end
  end

  def new
    @survey = Survey.new(uid: current_user.uid)
  end

  def destroy
    if @survey.uid == current_user.uid
      @survey.destroy
    end

    redirect_to surveys_path
  end

  def create
    @survey = Survey.new(survey_params.merge(
      uid: current_user.uid
    ))

    if @survey.save
      redirect_to survey_path(@survey.public_url)
    else
      render :new
    end
  end

  def answer
    choice = @survey.choices.find(params[:choice])
    comment = params[:comment]

    @survey.cast_answer(choice, comment, current_user)

    redirect_to survey_path(@survey.public_url)
  end

private

  def can_see_results?(survey)
    survey.public? || survey.uid == current_user.uid
  end

  def survey_params
    params.require(:survey).permit(
      :title, :description, :public, :allow_free_form,
      choices_attributes: [:body, :position]
    )
  end

  def load_survey_from_public_url
    @survey = survey_scope.eager.find_by!(public_url: params[:id])
  end

  def load_survey_from_private_url
    @survey = survey_scope.find_by!(private_url: params[:id])
  end

  def survey_scope
    Survey.eager
  end
end
