module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    # cookies.delete(:remember_token)
  end
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @_current_user = nil?
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def current_user
    @_current_user ||= User.find_by(id: session[:user_id])
  end
end
