class RoomTypesController < ApplicationController
  def index
    @pagy, @room_types = pagy RoomType.all, page: params[:page],
                                            items: Settings.page.default
  end

  def show
    @room_type = RoomType.find_by id: params[:id]
    if @room_type
      @list_rooms = @room_type.rooms.all
    else
      flash[:danger] = t ".find_fail"
      redirect_to room_types_path
    end
  end
end
