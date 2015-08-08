class SurveysController < ApplicationController
  before_action :load_survey_from_public_url, only: [:show, :answer]

  def show
  end

  def answer
  end

private

  def load_survey_from_public_url
    @survey = Survey.find_by!(public_url: params[:id])
  end
end
