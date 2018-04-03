class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :report_message
      t.integer :reported_id
      t.string :reported_type
      #add t.timestamps
    end

    #Add add_index :pictures, [:imageable_type, :imageable_id]


  end
end
