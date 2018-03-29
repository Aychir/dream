class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :report_message
      t.integer :reported_id
      t.string :reported_type
    end
  end
end
