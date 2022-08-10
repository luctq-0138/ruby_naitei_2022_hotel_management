class CreateRoomBookeds < ActiveRecord::Migration[6.1]
  def change
    create_table :room_bookeds do |t|
      t.belongs_to :room, index: true, foreign_key: true
      t.belongs_to :booking, index: true, foreign_key: true

      t.timestamps
    end
  end
end
