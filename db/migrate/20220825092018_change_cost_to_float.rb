class ChangeCostToFloat < ActiveRecord::Migration[6.1]
  def change
    change_table :room_types do |t|
	    t.change :cost, :float, null: false, default: 0.0
    end
  end
end
