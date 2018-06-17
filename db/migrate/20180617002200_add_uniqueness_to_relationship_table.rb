class AddUniquenessToRelationshipTable < ActiveRecord::Migration[5.1]
  def change
  	remove_index :follows, [:following_id, :follower_id]
  	add_index :follows, [:following_id, :follower_id], unique: true
  end
end
