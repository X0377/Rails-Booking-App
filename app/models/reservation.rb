class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :guest_count, presence: true, numericality: { greater_than: 0 }

  validate :check_in_must_be_future, :check_out_after_check_in

  def check_in_must_be_future
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, "は今日以降の日付を選択してください")
    end
  end

  def check_out_after_check_in
    if check_out.present? && check_out <= check_in
      errors.add(:check_out, "はチェックイン日より後の日付を選択してください")
    end
  end

  def total_price
    nights = (check_out.to_date - check_in.to_date).to_i
    nights * guest_count * room.price
  end

  def total_nights
    (check_out - check_in).to_i
  end
end
