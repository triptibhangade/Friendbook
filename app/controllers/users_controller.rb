class UsersController < ApplicationController

  before_action :set_user, except: [:index, :new, :create]
  before_action :required_signin, except: [:index, :create, :new]
  before_action :required_signout, only: [:new, :create]
  before_action :sent, only: [:index, :show, :sentrequest]
  before_action :received, only: [:index, :show, :friendrequest]
  before_action :all_friends, only: [:index, :show, :friends]
  before_action :friendship, except: [:new, :create, :edit, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
  end

  def create 
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to signin_path , notice: "#{@user.name} Successfully Signed Up." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'Account Successfully Updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Account was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def friendrequest
    if @received.nil?
      redirect_to users_path
    else
      @users = User.all
    end
  end

  def sentrequest
    if @sent.nil?
      redirect_to users_path
    else
      @users = User.all
    end
  end

  def friends
    if @friends.nil?
      redirect_to users_path
    else
      @users = User.all
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

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

    def sent
      @sent = current_user.sent_request
    end

    def received
      @received = current_user.received_request
    end

    def all_friends
      @friends = current_user.all_friends
    end

    def friendship
      @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id].to_i)|| Friendship.find_by(friend_id: current_user.id, user_id: params[:id].to_i)
    end
end
