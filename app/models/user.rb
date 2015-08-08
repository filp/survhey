class User
  include ActiveModel::Model
  attr_accessor :uid

  def surveys
    Survey.by_uid(uid)
  end
end
