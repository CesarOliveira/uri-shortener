class CreateLinks < ActiveRecord::Migration[6.0]
  def up
    create_table :links do |t|
      t.string :title
      t.string :identifier
      t.string :destination_url

      t.timestamps
    end
    add_index :links, :identifier, unique: true
    add_index :links, :destination_url, unique: true
  end

  def down
    remove_index :links, :identifier
    remove_index :links, :destination_url
    drop_table :links
  end
end
