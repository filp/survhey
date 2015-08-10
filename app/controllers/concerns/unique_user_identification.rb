module UniqueUserIdentification
  extend ActiveSupport::Concern

  UID_COOKIE_KEY = :survey_uid

  included do
    before_action :current_user
  end

  def current_user
    @current_user ||= identify_user
  end

  def identify_user
    uid_from_cookie = cookies.signed[UID_COOKIE_KEY]

    if uid_from_cookie.nil?
      uid_from_cookie = SecureRandom.hex(32)
      cookies.permanent.signed[UID_COOKIE_KEY] = uid_from_cookie
    end

    User.new(uid: uid_from_cookie)
  end

  def valid_uid?(uid)
    (uid && uid.length >= 30)
  end
end
