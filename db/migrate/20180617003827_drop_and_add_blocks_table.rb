class DropAndAddBlocksTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :blocks
  end

  def down
    raise ActiveRecord::IrreversibleMigration

    create_table :blocks do |t|
        	t.integer 'blocking_id', :null => false
        	t.integer 'blocker_id', :null => false
        	#Created the table and the two id's required for the relationship

        	t.timestamps null: false
    end

    add_index :blocks, :blocking_id
   	add_index :blocks, :blocker_id
   	add_index :blocks, [:blocking_id, :blocker_id], unique: true
  end
end
