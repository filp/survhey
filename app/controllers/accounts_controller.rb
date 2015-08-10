class AccountsController < ApplicationController
  def set_uid
    uid = params[:uid]

    if uid != current_user.uid && valid_uid?(uid) 
      cookies.permanent.signed[UID_COOKIE_KEY] = uid
      current_user.migrate_content(uid)
    end

    redirect_to surveys_path
  end
end
