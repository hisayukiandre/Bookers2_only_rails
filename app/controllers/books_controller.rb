class BooksController < ApplicationController
  # ユーザーがログインしていない場合、ログイン画面だけが表示されるように設定
  before_action :authenticate_user!

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.new
    @book_detail = Book.find(params[:id])
  end

  def create
  	@book = Book.new(book_params)
  	# No route matches {:action=>"show", :controller=>"books", :id=>nil}, missing required keys: [:id]というエラーが発生するので下の一行が必要
  	# id:nillというのはuser_idが空ということ
  	# formで送信され内容にはtitleとbodyしか入っていない
    @book.user_id = current_user.id  # ログイン中のユーザーのidを@book.user_idカラムに代入
    if @book.save
      redirect_to book_path(@book.id), notice: "You have creatad book successfully."
    else
      # renderするとindexのviewが表示されるから改めて一覧とユーザー情報の入ったインスタンスをviewに送る必要がある。
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
