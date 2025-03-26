class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]

  def edit
    # set_userでセット済みの@userにより、編集フォームを表示
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'プロフィールを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile, :avatar)
  end

  def authorize_user
    redirect_to root_path, alert: 'アクセスできません' unless @user == current_user
  end
end
