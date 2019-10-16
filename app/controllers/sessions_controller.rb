class SessionsController < ApplicationController

before_action :required_signin, only: [:destroy]
before_action :required_signout, only: [:new, :create]

  
 def new
 end

 def create
   @email = params[:email]
   @password = params[:password]
   @user = User.find_by(email:@email)

   if @user && @user.authenticate(@password)
    session[:user_id] = @user.id
    flash[:notice] = "#{@user.name} Successfully Signed In"
    redirect_to users_path
   else
     flash.now[:error] = "invalid email/password"
     render :new
   end

 end

 def destroy
  session[:user_id] = nil
  flash[:notice] = "Successfully Signed Out"
  redirect_to signin_path
 end

 private
  def required_signin
    unless current_user
      flash[:error] = "Please Sign In Properly"
      redirect_to signin_path
    end
  end

  def required_signout
    if current_user
      flash[:error] = "Please Sign out Properly"
      redirect_to users_path
    end
  end

end
