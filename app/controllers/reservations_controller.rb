class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room
  before_action :set_reservation, only: [:show, :destroy]
  before_action :check_reservation_ownership, only: [:show, :destroy]

  def index
    @reservations = current_user.reservations
    if @reservations.empty? && request.path != room_reservations_path
      redirect_to room_reservations_path(@room), alert: "現在、予約はありません。"
    end
  end

  def show
    # set_reservationで@reservationをセット
  end

  def new
    @reservation = @room.reservations.build
  end

  def confirm
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user

    unless @reservation.valid?
      render :new
      return
    end

    # 料金計算はモデルに切り出し
    @total_price = @reservation.total_price
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room

    if params[:back]
      render :new
      return
    end

    if @reservation.save
      redirect_to room_reservation_path(@room, @reservation), notice: "予約が完了しました"
    else
      render :new
    end
  end

  def destroy
    @reservation.destroy
    redirect_to room_reservations_path(@reservation.room), notice: "予約をキャンセルしました"
  end

  private

  def set_room
    if params[:room_id].present?
      @room = Room.find_by(id: params[:room_id].to_i)
    else
      @room = nil
    end
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def check_reservation_ownership
    unless @reservation.user == current_user
      redirect_to root_path, alert: "この操作は許可されていません"
    end
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guest_count)
  end
end