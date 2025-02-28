class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    @rooms = user_signed_in? ? current_user.rooms : Room.all
  end

  # ログインしてると検索結果に施設が表示されない
  def search
    @rooms = user_signed_in? ? current_user.rooms : Room.all

    if params[:keyword].present?
      @rooms = @rooms.where("name LIKE :keyword OR address LIKE :keyword OR description LIKE :keyword", keyword: "%#{params[:keyword]}%")
    end

    if params[:area].present?
      @rooms = @rooms.where("address LIKE?", "%#{params[:area]}%")
    end

    render :search_results
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id

    if @room.save
      redirect_to @room, notice: "施設を登録しました"
      # :roomだと /rooms の一覧ページへリダイレクトするので要チェック
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
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
end
