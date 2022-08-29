class ReviewsController < ApplicationController
  before_action :logged_in_user, :must_be_user, :find_room_type
  def create
    @review = @room_type.reviews.new review_params.except(:room_type_id)
    if @review.save
      flash[:success] = t ".add_review_success"
    else
      flash[:error] = t ".add_review_fail"
    end
    redirect_to @room_type
  end

  def update; end

  private

  def find_room_type
    @room_type = RoomType.find_by id: params[:review][:room_type_id]
    return if @room_type

    flash[:danger] = t ".not_found_room_type"
    redirect_to @room_type
  end

  def review_params
    params.require(:review).permit(:review, :star_rate, :user_id, :room_type_id)
  end
end
