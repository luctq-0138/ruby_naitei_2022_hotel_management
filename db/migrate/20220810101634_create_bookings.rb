class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.datetime :booking_date, null: false
      t.string :duration_of_stay, null: false
      t.datetime :check_in
      t.datetime :checkout
      t.integer :total_rooms_booked, null:false
      t.integer :status, null: false, default: 0
      t.belongs_to :user, index: true
      t.text :refuse_reason
      t.integer :user_star_rate
      t.decimal :total_amount, null: false
      t.timestamps
    end
  end
end
