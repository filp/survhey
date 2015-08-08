# == Schema Information
#
# Table name: choices
#
#  id        :integer          not null, primary key
#  body      :string           not null
#  survey_id :integer          not null
#  position  :integer          default("0"), not null
#
# Indexes
#
#  index_choices_on_position   (position)
#  index_choices_on_survey_id  (survey_id)
#

class Choice < ActiveRecord::Base
  belongs_to :survey
  has_many :answers

  validates :body, length: { minimum: 1, maximum: 140 }
end
