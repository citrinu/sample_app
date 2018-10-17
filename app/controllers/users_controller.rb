class UsersController < ApplicationController
  def new
    @user = User.new
  end


  #uses a find by id parameter on the User model
  #to pull the user from the db
  def show
    @user = User.find(params[:id])
    #debugger
  end

  #defining the create action from the user resource
  def create
      @user = User.new(user_params)
      if @user.save

      else
        render 'new'
      end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
