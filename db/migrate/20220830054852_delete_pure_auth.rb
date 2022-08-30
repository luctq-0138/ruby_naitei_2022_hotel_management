class DeletePureAuth < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :email
    remove_column :users, :password_digest
    remove_column :users, :remember_digest
  end
end
