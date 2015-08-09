class User
  include ActiveModel::Model
  attr_accessor :uid

  def surveys
    Survey.by_uid(uid)
  end

  def self.test_user(uid = "test-user")
    new(uid: uid)
  end
end
