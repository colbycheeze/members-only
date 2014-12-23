module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    remember_token = User.new_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_digest, User.digest(remember_token))
    self.current_user = user
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @_current_user = nil?
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user=(user)
    @_current_user = user
  end

  def current_user

    remember_token = User.digest(cookies[:remember_token])
    @_current_user ||= User.find_by(remember_digest: remember_token)
  end
end
