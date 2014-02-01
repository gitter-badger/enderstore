class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.column :name, :text
      t.column :title, :text
      t.column :content, :text
      t.timestamps
    end
  end
end
