class CreateAdminUsers < ActiveRecord::Migration
  def up
    create_table :admin_users do |t|
    	t.string :first_name, :limit => 30
    	t.string :last_name, :limit => 50
    	t.string :username, :limit => 30
    	t.string :email, :limit => 100
    	t.string :password_digest
      t.timestamps null: false
    end
    add_index("admin_users","username")
  end

  def down
  	drop_table :admin_users
  end
end
