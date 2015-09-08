class CreatePageEdits < ActiveRecord::Migration
  def up
    create_table :page_edits do |t|
    	t.references :page
    	t.references :admin_user
      t.timestamps null: false
    end
    add_index :page_edits, ["page_id", "admin_user_id"]
  end

  def down
  	drop_table :page_edits
  end
end
