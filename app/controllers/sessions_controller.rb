class SessionsController < ApplicationController
  def new
  end

  def create
    #user is logging in
    #search for a user by email used to login
    #using params hash containing the session email
    user = User.find_by(email: params[:session][:email].downcase)
    #check if the password matches
    if user && user.authenticate(params[:session][:password])
      #login the user
      #redirect to the users page
      #user_url(user) wwww.test.com/user/id
      log_in user
      redirect_to user
    else
      #error message
      flash.now[:danger] = "Invalid Email/Password Combo"
      render 'new'
    end
  end


  def destroy
  end
end
