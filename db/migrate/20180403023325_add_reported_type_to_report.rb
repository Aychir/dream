class AddReportedTypeToReport < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :reported_type, :string
  end
end
