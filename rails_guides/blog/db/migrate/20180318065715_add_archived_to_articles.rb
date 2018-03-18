class AddArchivedToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :archived, :boolean
  end
end
