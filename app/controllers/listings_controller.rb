class ListingsController < ApplicationController
  def index
    # RESUME PROOF: Using .includes(:user) eliminates N+1 queries.
    # Without this, Rails would query the User table for every single listing individually.
    @listings = Listing.includes(:user).all

    render json: @listings.as_json(include: { user: { only: [:username] } })
  end

  def create
    # For prototype, we will just assign the first user found
    user = User.first || User.create(username: "Student_Dev", email: "test@asu.edu")
    
    @listing = user.listings.build(listing_params)

    if @listing.save
      render json: @listing, status: :created
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  private
    def listing_params
      params.require(:listing).permit(:title, :description, :price)
    end
end