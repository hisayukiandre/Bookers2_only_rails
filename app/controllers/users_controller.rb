class UsersController < ApplicationController
  # ユーザーがログインしていない場合、ログイン画面だけが表示されるように設定
  before_action :authenticate_user!
  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    #他のユーザのユーザ編集ページにurlからアクセスできないようにするため
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end


# renderとredirect_toの違い
# redirect_toはルーティングを通すのに対して、renderはルーティングを通さない
# そのため、redirect_toするとアクションが実行される
# 一方で、renderの場合は指定されたviewファイルをテンプレートとして表示するだけ
# そのため、render :indexとあった場合index.html.erbを表示する
