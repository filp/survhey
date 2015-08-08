# == Schema Information
#
# Table name: surveys
#
#  id          :integer          not null, primary key
#  public_url  :string           not null
#  private_url :string           not null
#  title       :string           not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  uid         :string           not null
#  public      :boolean          default("false"), not null
#
# Indexes
#
#  index_surveys_on_private_url  (private_url) UNIQUE
#  index_surveys_on_public_url   (public_url) UNIQUE
#

class Survey < ActiveRecord::Base
  before_validation :assign_urls

  has_many :choices
  has_many :answers

  validates :title, length: { minimum: 1, maximum: 140 }
  validates :description, length: { maximum: 1024 }
  validate :number_of_choices

  def answers?
    answers.any?
  end

  def total_answers
    answers.count
  end

  def answers_from_uid(uid)
    answers.where(uid: uid)
  end

private

  def assign_urls
    assign_attributes(
      public_url:  generate_url(12),
      private_url: generate_url(22)
    )
  end

  def generate_url(size)
    SecureRandom.hex(size)
  end

  # Ensure that a survey always has at least one choice
  def number_of_choices
    errors.add(:base, :atleast_one_choice) unless choices.any?
  end
end
