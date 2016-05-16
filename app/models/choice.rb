# == Schema Information
#
# Table name: choices
#
#  id        :integer          not null, primary key
#  body      :string           not null
#  survey_id :integer          not null
#  position  :integer          default("0"), not null
#  free_form :boolean          default("false"), not null
#
# Indexes
#
#  index_choices_on_free_form  (free_form)
#  index_choices_on_position   (position)
#  index_choices_on_survey_id  (survey_id)
#

class Choice < ActiveRecord::Base
  auto_strip_attributes :body

  belongs_to :survey
  has_many :answers, dependent: :destroy

  validates :body, length: { minimum: 1, maximum: 140 }
end
