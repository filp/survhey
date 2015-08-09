class AccountsController < ApplicationController
  def set_uid
    uid = params[:uid]

    if uid && uid != current_user.uid
      cookies[UID_COOKIE_KEY] = uid
      current_user.migrate_content(uid)
    end

    redirect_to root_path
  end
end
