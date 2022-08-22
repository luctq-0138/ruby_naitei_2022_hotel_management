class ReviewsController < ApplicationController
  before_action :find_room_type, :logged_in_user, :must_be_user
  def create
    if @room_type.reviews.create(review: params[:review][:review_description],
                                 star_rate: params[:review][:star],
                                 user_id: current_user.id)
      flash[:success] = t ".add_review_success"
    else
      flash[:danger] = t ".add_review_fail"
    end
    redirect_to @room_type
  end

  def update; end

  def find_room_type
    @room_type = RoomType.find_by id: params[:review][:room_type_id]
    return if @room_type

    flash[:danger] = t ".not_found_room_type"
    redirect_to @room_type
  end
end
