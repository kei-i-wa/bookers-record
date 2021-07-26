class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :correct_user, only: [:edit, :update]



  def show
    @user=User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @book=Book.new
  end

  def index
   @users=User.page(params[:page]).reverse_order
   @book=Book.new
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id),notice:'You have updated user successfully.'
    else
      render:edit
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_url(current_user)) unless @user == current_user
  end

  
   private

  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end

end
