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

  auto_strip_attributes :title, :description

  has_many :choices, -> { order(position: :desc) }, dependent: :destroy
  has_many :answers

  scope :ordered, -> { order(created_at: :desc) }
  scope :eager, -> { includes(:choices, :answers) }
  scope :by_uid, -> uid { where(uid: uid) }

  accepts_nested_attributes_for :choices, reject_if: :all_blank

  validates :title, length: { minimum: 1, maximum: 140 }
  validates :description, length: { maximum: 1024 }
  validate :number_of_choices

  def private?
    !public?
  end

  def answers?
    answers.any?
  end

  def total_answers
    answers.count
  end

  def top_choice
    choice = answers.group(:choice_id).count.sort_by { |k, v| v }.last
    choices.find(choice.first)
  end

  def answered?(user)
    answers.where(uid: user.uid).any?
  end

  def answer_by(user)
    answers.find_by(uid: user.uid)
  end

  def created_by?(user)
    uid == user.uid
  end

  def cast_answer(choice, user)
    raise "Cannot create answer on this choice - wrong survey" if choice.survey != self

    unless answered?(user)
      choice.answers.create!(survey: self, uid: user.uid)
    end
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
    errors.add(:base, :atleast_two_choices) unless choices.any?
  end
end
