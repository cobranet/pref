class CreateWaitings < ActiveRecord::Migration

  def change
    create_table :waitings do |t|
      t.column :user_id , :integer
      t.timestamps
    end
    add_index :waitings, :user_id , :unique => false 
  end

end
