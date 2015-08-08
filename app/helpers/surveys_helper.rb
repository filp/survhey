module SurveysHelper
  def created_survey?(survey)
    survey.uid == current_user.uid
  end

  def answered?(survey)
    survey.answers_from_uid(current_user.uid).any?
  end
end
