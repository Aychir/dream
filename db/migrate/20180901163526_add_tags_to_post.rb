class AddTagsToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :tags, :text
  end
end
