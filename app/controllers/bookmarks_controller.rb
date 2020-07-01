class BookmarksController < ApplicationController
  before_action :authenticate_user
  before_action :set_bookmark, only: [:show, :update, :destroy]

  def index 
    bookmarks = current_user.bookmarks.order(id: "asc")
    render json: bookmarks
  end 

  def show 
    render json: @bookmark
  end 

  def create 
    current_user.bookmarks.create(bookmark_params)
    render json: "created bookmark", status: :created
  end 

  def update 
    @bookmark.update(bookmark_params)
    render json: "bookmark updated", status: 200
  end 

  def destroy
    @bookmark.destroy
    render json: "bookmark deleted", status: 200
  end 

  private 

  def bookmark_params 
    params.require(:bookmark).permit(:title, :description, :url)
  end 

  def set_bookmark 
    @bookmark = Bookmark.find(params[:id])
  end 
end