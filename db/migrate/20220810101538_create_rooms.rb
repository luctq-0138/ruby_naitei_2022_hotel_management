class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :number, null: false, unique: true
      t.string :name
      t.decimal :cost, precision: 10, scale: 2
      t.integer :star_rate
      t.boolean :is_available, default: false
      t.string :image
      t.belongs_to :room_type, index: true, foreign_key: true

      t.timestamps
    end
  end
end
