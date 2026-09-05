class AddTokenToSessions < ActiveRecord::Migration[8.1]

  def change
    add_column :sessions, :token, :string
  end

end
