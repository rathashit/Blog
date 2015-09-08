class CreateSections < ActiveRecord::Migration
  def up
    create_table :sections do |t|
    	t.integer :page_id
    	t.string :name
    	t.integer :position
    	t.text :content
    	t.boolean :visible
    	t.string :img_url
    	t.string :img_desc

      t.timestamps null: false
    end
    add_index("sections","page_id")
  end

  def down
  	drop_table :sections
  end
end
