class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user # redirect_to user_url(@user)と同じ。勝手に解釈
      # 本来 redirect_to user_url(@user.id)と書くところだが、モデルオブジェクトが渡されるとidを取得しようとしてくれるため、@userでも、@user.idと同じ結果になる。
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
