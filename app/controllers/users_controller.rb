class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)


   if @user
    session[:user_id] = @user.id
    flash[:success] = "Signup Succesful!"
    redirect_to root_path
   else
    flash[:danger] = "Sorry, the email and/or password you entered was invalid. Please try again."
    render :new
   end

    # redirect_to @user
    # render :json => params[:user]
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end




end
