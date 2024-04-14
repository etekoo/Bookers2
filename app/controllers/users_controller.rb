class UsersController < ApplicationController
  def new
  @book = current_user.books.new
  end

def index
    @users = User.all
    @book = Book.new
  end
   
  def show
    @user = User.find(params[:id])
    @books = @user.books   
    @book = Book.new
    
  end

  def edit
    is_matching_login_user
  
    @user = User.find(params[:id])
  end
  
 def update
  is_matching_login_user
  @user = User.find(params[:id])
  if @user.update(user_params)
    flash[:notice] = "successfully"
    redirect_to user_path(@user)
  else
    flash[:notice] = "error"
    flash.now[:error] = @user.errors.full_messages
    render 'edit' # 編集ページのビューを表示する
  end
end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
  user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to user_path(current_user.id)
  end
end
    
end
