class CreateLinks < ActiveRecord::Migration[6.0]
  def up
    create_table :links do |t|
      t.string :title
      t.string :identifier
      t.string :destination_url

      t.timestamps
    end
    add_index :links, :identifier, unique: true
  end

  def down
    remove_index :links, :identifier
    drop_table :links
  end
end
