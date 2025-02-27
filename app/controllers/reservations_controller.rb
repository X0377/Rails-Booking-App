class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room

  def index
    @reservations = current_user.reservations

    if @reservations.empty? && request.path != room_reservations_path
      redirect_to room_reservations_path(@room), alert: "現在、予約はありません。"
    end
  end

  def show
    @reservation = Reservation.find_by(params[:id])
  end

  def new
    @reservation = @room.reservations.build
  end

  def create
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to room_reservation_path(@room, @reservation), notice: "予約が完了しました"
    else
      render :new
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
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

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guest_count)
  end
end
