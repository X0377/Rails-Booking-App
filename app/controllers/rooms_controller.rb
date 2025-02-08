class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id

    if @room.save
      redirect_to @room, notice: "施設を登録しました"
      # :roomだと /rooms の一覧ページへリダイレクト
    else
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    # if
    #else
    #  render :edit
    #end
  end

  def destroy
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
