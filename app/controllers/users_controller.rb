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

end
