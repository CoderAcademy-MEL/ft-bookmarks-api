class BookmarksController < ApplicationController
  before_action :authenticate_user
  before_action :set_bookmark, only: %i[show update destroy update_image]

  def index
    bookmarks = current_user.bookmarks.with_attached_image
    render json: { bookmarks: generate_image_urls(bookmarks), current_user: current_user.email }
  end

  def show
    render json: @bookmark
  end

  def create
    bookmark = current_user.bookmarks.create(bookmark_params)
    if bookmark_params[:image]
      render json: { bookmark: bookmark, image: url_for(bookmark.image) }, status: :created
    else
      render json: { bookmark: bookmark, image: '' }, status: :created
    end
  end

  def update
    @bookmark.update(bookmark_params)
    render json: 'bookmark updated', status: :ok
  end

  def destroy
    @bookmark.destroy
    render json: 'bookmark deleted', status: :ok
  end

  def update_image
    @bookmark.image.purge
    @bookmark.image.attach(bookmark_params[:image])
    render json: url_for(@bookmark.image)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :description, :url, :image)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def generate_image_urls(bookmarks)
    bookmarks.map do |bookmark|
      if bookmark.image.attached?
        bookmark.attributes.merge(image: url_for(bookmark.image))
      else
        bookmark
      end
    end
  end
end
