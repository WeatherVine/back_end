class CreateUserWines < ActiveRecord::Migration[5.2]
  def change
    create_table :user_wines do |t|
      t.references :wine, foreign_key: true
      t.integer :user_id, index: true
      t.string :comment

      t.timestamps
    end
  end
end
