class AddIndexToShelvesUserId < ActiveRecord::Migration
  def change
    add_index :shelves, :user_id
  end
end
