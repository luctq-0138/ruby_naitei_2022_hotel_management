class CreateRoomTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :room_types do |t|
      t.string :type_name, null: false
      t.text :type_description

      t.timestamps
    end
  end
end
