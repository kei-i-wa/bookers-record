class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit]

  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    tag_list=params[:book][:tag_name].split(',')
    if  @book.save
        @book.save_tag(tag_list)
        redirect_to books_path(@book),notice:'You have created book successfully.'
    else
        @books=Book.page(params[:page]).reverse_order
        render:index
    end
  end

  def index
    @book=Book.new
    books_order = Book.order('id DESC')
    @books=books_order.page(params[:page])
    @tag_list=Tag.all
  end
  
  def favorite_order
    books = Book.includes(:favorited_users).
      sort {|a,b| 
        b.favorited_users.includes(:favorites).size <=> 
        a.favorited_users.includes(:favorites).size
      }
     @books=Kaminari.paginate_array(books).page(params[:page]).per(25)
     @book = Book.new
  end
    

  def show
    @books=Book.find(params[:id])
    # @book=BooksTag.new
    @book_comment = BookComment.new
    # @book_comments = @book.book_comments.order(created_at: :desc)
    @book_tags = @books.tags

  end

  def edit
    @book=Book.find(params[:id])
  end


  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id),notice:'You have updated book successfully.'
    else
    render:edit
    end
  end

  def destroy
    @book=Book.find(params[:id])
    if @book.destroy
    redirect_to books_path
    end
  end
  
   def search_book
     @book=Book.new
     @books = Book.search(params[:keyword])
   end
   
    def search_tag
      @book=Book.new
      @tag_list = Tag.all
      @tag = Tag.find(params[:tag_id])
      @books = @tag.books.all      
    end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
    redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title,:body,:category)
  end
  
end