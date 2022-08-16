class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :number, null: false, unique: true
      t.string :name
      t.boolean :is_available, default: true
      t.belongs_to :room_type, index: true, foreign_key: true
      t.timestamps
    end
  end
end
