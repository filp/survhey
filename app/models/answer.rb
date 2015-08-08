# == Schema Information
#
# Table name: answers
#
#  id         :integer          not null, primary key
#  uid        :string           not null
#  choice_id  :integer          not null
#  survey_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_answers_on_choice_id  (choice_id)
#  index_answers_on_survey_id  (survey_id)
#

class Answer < ActiveRecord::Base
  belongs_to :survey
  belongs_to :choice
end
