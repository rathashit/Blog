class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string :name
      t.string :img_url
      t.text :desc
      t.integer :priority
      t.boolean :visibles
      t.timestamps null: false
    end
  end

  def down
  	drop_table :categories
  end
  
end
