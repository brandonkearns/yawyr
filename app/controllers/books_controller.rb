class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]
  before_action :signed_in_user, except: [:index, :show]
  before_action :correct_user, except: [:new, :create, :index, :show]

  def index
    @books = current_user.books
  end

  def show
    if !current_user?(current_user)
      redirect_to new_book_path
    else
      set_book
    end
  end

  def new
    # @book = Book.new
    @books = Book.search(params[:query])

    #search function
  end

  def create
    @shelf = current_user.shelves.find(book_params[:shelf_id])
    @book = @shelf.books.new(book_params)
    if @book.save
      flash[:success] = "#{@book.title} has been added to your shelf!"
      redirect_to shelf_path(@shelf.id)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @book.update_attribute(:pages_read, book_params[:pages_read])
      flash[:success] = "You are #{@book.page_count - @book.pages_read} pages from completing #{@book.title}!"
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = "#{@book.title} has been taken down."
    redirect_to books_path
  end

  private

    def book_params
      params.require(:book).permit(:title, :author, :thumbnail, :page_count, :shelf_id)
    end

    def set_book
      @book = current_user.books.find(params[:id])
    end

    def correct_user
      unless current_user?(@book.shelf.user) || current_user.admin?
        redirect_to user_path(current_user)
      end
    end
end
