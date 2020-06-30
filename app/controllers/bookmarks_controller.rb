class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :update, :destroy]

  def index 
    bookmarks = Bookmark.all.order(id: "asc")
    render json: bookmarks
  end 

  def show 
    render json: bookmark
  end 

  def create 
    Bookmark.create(bookmark_params)
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
