class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room
  before_action :set_reservation, only: [:show, :destroy]

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

    # 日程の妥当性チェック
    if @reservation.invalid?
      render :new
      return
    end

    # 料金計算（泊数 × 部屋の料金）
    nights = (@reservation.check_out.to_date - @reservation.check_in.to_date).to_i
    @total_price = nights * @reservation.guest_count * @room.price
    render :confirm
  end

  def create
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user

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

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guest_count)
  end
end