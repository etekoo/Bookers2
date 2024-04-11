class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id # ログイン中のユーザーを関連付ける
  if @book.save
    redirect_to books_path
  else
     # バリデーションエラーがある場合の処理
    puts @book.errors.full_messages # 追加
    redirect_to new_book_path
  end
end

  def edit
  @book = Book.find(params[:id])
end

def update
    @book = Book.find(params[:id])
     @book.update(book_params)
      redirect_to book_path(@book.id)
    
  end
  
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
