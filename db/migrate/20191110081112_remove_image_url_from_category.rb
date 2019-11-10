class RemoveImageUrlFromCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :image_url, :text
  end
end
