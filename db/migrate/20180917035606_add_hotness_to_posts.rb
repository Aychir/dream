class AddHotnessToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :hotness, :integer
  end
end
