class CreateContacts < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
    	t.string :name, :limit => 100
    	t.string :email, :limit => 100
    	t.string :message, :limit => 500
    	t.boolean :read, :default => false
      t.timestamps null: false
    end
  end
  def down
  	drop_table :contacts
  end
end
