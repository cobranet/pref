class CreatePrefgames < ActiveRecord::Migration
  def change
    create_table :prefgames do |t|
      t.column :game, :string
      t.column :status , :string
      t.column :east, :intiger 
      t.column :south,:intiger  
      t.column :west, :intiger
      t.timestamps
    end
  end
end
