class CreateHits < ActiveRecord::Migration[6.0]
  def change
    create_table :hits do |t|
      t.references :link, null: false, foreign_key: true
      t.string :identifier

      t.timestamps
    end
  end
end
