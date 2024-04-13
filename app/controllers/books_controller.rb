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
  else
    puts @book.errors.full_messages
    redirect_to books_path
  end
end

  def edit
  @book = Book.find(params[:id])
end

def update
  @book = current_user.books.find(params[:id])
  if @book.update(book_params)
    redirect_to book_path(@book.id)
  else
    # バリデーションエラーがある場合の処理
    puts @book.errors.full_messages 
    redirect_to edit_book_path(@book.id)
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
  
end
