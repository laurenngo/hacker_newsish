class SessionsController < ApplicationController

#login page/GET

  def new
  end

  def create
   # render :json => params[:user]
   @user = User.authenticate(params[:user][:email], params[:user][:password])
   # render json:@user

   if @user
    session[:user_id] = @user.id
    flash[:success] = "Login Succesful!"
    redirect_to root_path
   else
    flash[:danger] = "Sorry, your email and/or password did not match. Please try to login again."
    render :new
   end
  end

  # delete the session
  def destroy
    session[:user_id] = nil
    flash[:info] = "You have been successfully logged out."
    redirect_to login_path

  end


end

