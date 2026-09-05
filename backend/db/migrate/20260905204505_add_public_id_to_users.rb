class AddPublicIdToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :public_id, :uuid, default: -> { "gen_random_uuid()" }, null: false
    add_index :users, :public_id, unique: true
  end
end
