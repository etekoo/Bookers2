class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
  @post = Book.find(params[:id])
  @user = @post.user
  @book = Book.new 
  end
  
  def create
  @book = current_user.books.build(book_params)
  if @book.save
    redirect_to book_url(@book)
    flash[:notice] = "successfully"
  else
    # バリデーションエラーがある場合の処理
    flash[:notice] = "error"
    flash.now[:error] = @book.errors.full_messages
    @books = Book.all # ビューで使用するために@booksに全ての書籍を代入する
    render 'index'
  end
  end

  def edit
  @book = Book.find(params[:id])
  @post = Book.find(params[:id])
  end

def update
  @book = current_user.books.find(params[:id])
  if @book.update(book_params)
    flash[:notice] = "successfully"
    redirect_to book_path(@book.id)
  else
    # バリデーションエラーがある場合の処理
    flash[:notice] = "error"
    flash.now[:error] = @book.errors.full_messages
    render 'edit' # 編集ページのビューを表示する
  end
end
  
  
  def destroy
  @post = Book.find(params[:id])
  @post.destroy
  redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
  
end
