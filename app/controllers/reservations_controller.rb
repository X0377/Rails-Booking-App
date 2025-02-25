class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room

  def new
    @reservation = @room.reservations.new
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

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guest_count)
  end
end
