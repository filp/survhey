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
        render json: {
          url: @survey.public_url,
          title: @survey.title,
          created_at: @survey.created_at.iso8601,
          results: @survey.choices.map do |choice|
            {
              id: choice.id,
              body: choice.body,
              total_answers: choice.answers.count
            }
          end
        }
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

    @survey.cast_answer(choice, current_user)

    redirect_to survey_path(@survey.public_url)
  end

private

  def survey_params
    params.require(:survey).permit(
      :title, :description, :public, choices_attributes: [:body, :position]
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
