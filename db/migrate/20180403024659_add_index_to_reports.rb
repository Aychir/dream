class AddIndexToReports < ActiveRecord::Migration[5.1]
  def change
  	add_index :reports, [:reported_type, :reported_id], unique: true
  end
end
