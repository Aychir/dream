class AddIndexToReports < ActiveRecord::Migration[5.1]
  def change
  	add_index :reports, [:user_id, :reported_id], unique: true
  end
end
