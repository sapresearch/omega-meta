class CreateOmegaHostingAccounts < ActiveRecord::Migration
  def change
    create_table :omega_hosting_accounts do |t|
      t.belongs_to :user
      t.string :name

      t.timestamps
    end
    add_index :omega_hosting_accounts, :user_id
  end
end
