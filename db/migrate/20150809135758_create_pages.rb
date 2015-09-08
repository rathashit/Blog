class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
    	t.integer :category_id
    	t.string :title
    	t.text :content
    	t.string :image_url
    	t.boolean :visible

      t.timestamps null: false
    end
    add_index("pages", "category_id")
  end

 def down
 	drop_table :pages 	
 end
end
