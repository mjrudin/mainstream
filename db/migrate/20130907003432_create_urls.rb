class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :link
      t.integer :frequency
      t.string :topic

      t.timestamps
    end
  end
end
