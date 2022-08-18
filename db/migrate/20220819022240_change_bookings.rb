class ChangeBookings < ActiveRecord::Migration[6.1]
  def change
    change_table :bookings do |t|
	    t.remove :duration_of_stay, null: false
      t.change :check_in, :datetime, null: false
      t.remove :checkout, null: false
      t.datetime :check_out, null: false
      t.remove :total_rooms_booked, null:false
      t.remove :total_amount, null: false
    end
  end
end
