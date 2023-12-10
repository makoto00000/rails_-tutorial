class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # redirect_to user_url(@user)と同じ。勝手に解釈
      # 本来 redirect_to user_url(@user.id)と書くところだが、モデルオブジェクトが渡されるとidを取得しようとしてくれるため、@userでも、@user.idと同じ結果になる。
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新に成功したときの処理
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path, status: :see_other
    end
  end
end
