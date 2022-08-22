class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :room_type, index: true, foreign_key: true
      t.text :review, null: false
      t.integer :star_rate, null: false

      t.timestamps
    end
  end
end
