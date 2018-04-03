class RemoveReportedTypeFromReports < ActiveRecord::Migration[5.1]
  def change
    remove_column :reports, :reported_type, :string
  end
end
