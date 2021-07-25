class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :correct_user, only: [:edit, :update]



  def show
    @user=User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    # from=Time.current.at_beginning_of_day
    # to=Time.current.at_end_of_day
    # @book_a_day=@books.where(created_at: from...to)
    # @book_a_yesterday=@books.where(created_at: 1.day.ago.all_day)
    # @book_a_week=@books.where(created_at: 6.days.ago...to)
    # @book_a_lastweek=@books.where(created_at: 14.days.ago...to-7.days)
    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday
    # @twodays_book = @books.created_2days
    # @threedays_book = @books.created_3days
    # @fourdays_book = @books.created_4days
    # @fivedays_book = @books.created_5days
    # @sixdays_book = @books.created_6days
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    # @books_count = Book.group_by_day(:created_at).size
    # @book_by_day = @books.group_by_day(:created_at).size
    # @chartlabels = @book_by_day.map(&:first).to_json.html_safe
    # @chartdatas = @book_by_day.map(&:second)
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
