module SessionsHelper


  def log_in(user)
    session[:user_id] = user.id
  end

  #allows us to check for the current user
  #changes can be made based on the results
  def current_user
    if  (user_id = session[:user_id])
      @current_user || User.find_by(id: session[:user_id])
    elsif (user_id = cookies[:user_id])
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #creates a permanent + signed cookie based on the user id
  #creates a cookie to store the generated token
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #removes cookies on logout
  def forget(user)
    user.forget # updates diget to nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end




end
