class AddImageContentType < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :content_type, :string, null: true
  end
end
