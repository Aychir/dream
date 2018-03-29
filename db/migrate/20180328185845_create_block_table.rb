class CreateBlockTable < ActiveRecord::Migration[5.1]
  def change
      #unless table_exists? :follows
    	create_table :blocks do |t|
        t.integer 'blocking_id', :null => false
        t.integer 'blocker_id', :null => false
        #Created the table and the two id's required for the relationship

        t.timestamps null: false
      #end
  end
   add_index :blocks, :blocking_id
   add_index :blocks, :blocker_id
   add_index :blocks, [:blocking_id, :blocker_id]
   #Ensure that the combination of follower/following is unique
   #Add indices in our table to allow both followers and followings
	end
end
