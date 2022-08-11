class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.belongs_to :booking, index: true, foreign_key: true
      t.string :type, null: false
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
