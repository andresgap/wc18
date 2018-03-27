class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :picture, :string
    add_column :users, :image, :string
    add_column :users, :active, :boolean, default: true
    add_column :users, :admin, :boolean, default: false
  end
end
