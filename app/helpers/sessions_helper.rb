module SessionsHelper


  def log_in(user)
    session[:user_id] = user.id
  end

  #allows us to check for the current user
  #changes can be made based on the results
  def current_user
    if session[:user_id]
      @current_user || User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
