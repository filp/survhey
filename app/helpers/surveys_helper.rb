module SurveysHelper
  def created_survey?(survey)
    survey.uid == current_user.uid
  end
end
