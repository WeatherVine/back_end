class CreateWines < ActiveRecord::Migration[5.2]
  def change
    create_table :wines do |t|
      t.integer :api_id, index: { unique: true }
      t.string :name

      t.timestamps
    end
  end
end
