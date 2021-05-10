class RemoveTagsFromImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :tags, :string
  end
end
