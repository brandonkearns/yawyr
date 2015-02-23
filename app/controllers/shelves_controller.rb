class ShelvesController < ApplicationController
  before_action :set_shelf,      only:   [:show, :edit, :update, :destroy]
  before_action :signed_in_user, except: [:index, :show]
  before_action :correct_user,   except: [:new, :create, :index, :show]

  def index
    if !signed_in?
      flash[:success] = "Sign in and make your own shelves! wyrd."
      redirect_to signin_path
    else
      @shelves = current_user.shelves
    end
  end

  def show
    @books = @shelf.books
    # @shelf = Shelf.find(params[:id])
  end

  def new
    @shelf = Shelf.new
  end

  def create
    @shelf = current_user.shelves.new(shelf_params)
    if @shelf.save
      flash[:success] = "You just added a new shelf! Put some books on it!"
      redirect_to shelves_path
    else
      render 'new'
    end
  end

  def edit
    # @shelf = Shelf.find(params[:id])
  end

  def update
    if @shelf.update_attributes(shelf_params)
      flash[:success] = "Your #{@shelf.name} shelf has been updated."
      redirect_to shelf_path(@shelf.id)
    else
      render 'edit'
    end
  end

  def destroy
    @shelf.destroy
    flash[:success] = "You have removed your #{@shelf.name} shelf."
    redirect_to shelves_path
  end

  private
    def shelf_params
      params.require(:shelf).permit(:name)
    end

    def set_shelf
      @shelf = Shelf.find(params[:id])
    end

    def correct_user
      unless current_user?(@shelf.user) || current_user.admin?
        redirect_to user_path(current_user)
      end
    end

end
