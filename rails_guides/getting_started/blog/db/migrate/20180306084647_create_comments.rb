class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body

      # This will create an integer column called article_id, an index for it
      # and a foreign key contraint that points to the id column of articles
      # table
      t.references :article, foreign_key: true 

      t.timestamps
    end
  end
end
