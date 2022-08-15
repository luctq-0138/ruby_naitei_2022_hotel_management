class CreateRoomTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :room_types do |t|
      t.string :name, null: false
      t.decimal :cost, precision: 10, scale: 2
      t.integer :size
      t.integer :capacity
      t.string :services
      t.integer :star_rate
      t.string :image
      t.text :description
      t.timestamps
    end
  end
end
