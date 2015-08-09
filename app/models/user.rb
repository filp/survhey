class User
  include ActiveModel::Model
  attr_accessor :uid

  def surveys
    Survey.by_uid(uid)
  end

  def answers
    Answer.by_uid(uid)
  end

  def migrate_content(new_uid)
    surveys.update_all(uid: new_uid)
    answers.update_all(uid: new_uid)
  end

  def self.test_user(uid = "test-user")
    new(uid: uid)
  end
end
