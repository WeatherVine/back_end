class AddUniquenessToApiIdInWines < ActiveRecord::Migration[5.2]
  def change
    change_column :wines, :api_id, :string, unique: true
  end
end
