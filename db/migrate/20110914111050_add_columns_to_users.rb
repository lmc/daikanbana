class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_username, :string
    add_column :users, :github_api_key, :string
    add_column :users, :status, :string
  end
end
