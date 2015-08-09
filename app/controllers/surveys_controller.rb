class SurveysController < ApplicationController
  before_action :load_survey_from_public_url, only: [:show, :answer]

  def show
  end

  def new
    @survey = Survey.new(uid: current_user.uid)
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
    @survey = Survey.eager.find_by!(public_url: params[:id])
  end
end
