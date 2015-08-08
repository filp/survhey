module UniqueUserIdentification
  extend ActiveSupport::Concern

  COOKIE_KEY = :survey_uid

  included do
    before_action :current_user
  end

  def current_user
    @current_user ||= identify_user
  end

  def identify_user
    uid_from_cookie = cookies[COOKIE_KEY]

    if uid_from_cookie.nil?
      uid_from_cookie = SecureRandom.hex(32)
      cookies[COOKIE_KEY] = uid_from_cookie
    end

    User.new(uid: uid_from_cookie)
  end
end
