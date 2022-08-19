class ChangePayments < ActiveRecord::Migration[6.1]
  def change
    change_table :payments do |t|
	    t.change :payment_type, :string, null: false, default: "offline"
    end
  end
end
