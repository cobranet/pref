class CreateHands < ActiveRecord::Migration
  def change
    create_table :hands do |t|
      t.column :cards,:string
      t.timestamps
    end
  end
end
