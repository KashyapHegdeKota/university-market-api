class ListingsController < ApplicationController
  def index
    @listings = Listing.includes(:user).with_attached_image.all
    render json: @listings.map { |listing|
      listing.as_json(include: { user: { only: [:username] } }).merge(
        image_url: listing.image.attached? ? url_for(listing.image) : nil
      )
    }
  end

  def show
    @listing = Listing.includes(:user).find(params[:id])
    render json: @listing.as_json(include: { user: { only: [:username] } }).merge(
      image_url: @listing.image.attached? ? url_for(@listing.image) : nil
    )
  end

  def create
    # For prototype, we default to the first user again
    user = User.first
    
    unless user
      render json: { error: "No users found. Please seed the database with at least one user." }, status: :not_found
      return
    end

    @listing = user.listings.build(listing_params)
    if @listing.save
      render json: {message: "Listing created successfully"}, status: :created
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end
  private
    def listing_params
      params.require(:listing).permit(:title, :description, :price, :image)
    end
end