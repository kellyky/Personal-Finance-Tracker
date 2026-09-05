class MakeSessionTokenUnique < ActiveRecord::Migration[8.1]

  def change
    add_index :sessions, :token, unique: true
  end

end
