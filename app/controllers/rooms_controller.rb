class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :check_room_ownership, only: [:edit, :update, :destroy]

  def index
    @rooms = user_signed_in? ? current_user.rooms : []
  end

  def search
    #検索結果ページではすべての施設を対象にする
    @rooms = Room.all

    if params[:keyword].present?
      @rooms = @rooms.where("name LIKE :keyword OR address LIKE :keyword OR description LIKE :keyword", keyword: "%#{params[:keyword]}%")
    end

    if params[:area].present?
      @rooms = @rooms.where("address LIKE?", "#{params[:area]}%")
    end

    render :search_results
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: "施設を登録しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:room][:remove_image] == '1' && @room.image.attached?
      @room.image.purge
    end

    if @room.update(room_params)
      redirect_to @room, notice: "施設情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "施設を削除しました"
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end

  def check_room_ownership
    unless @room.user == current_user
      redirect_to root_path, alert: "この操作は許可されていません"
    end
  end
end
