# bin/rails g migration CreateJoinTableProductCategory product category
# command syntax: CreateJoinTableXxxYyy xxx yyy
#
# create_join_table creates an HABTM (has and belongs to many) join table
#
# Generated content in schema.rb:
# 
#  create_table "categories_products", id: false, force: :cascade do |t|
#    t.integer "product_id", null: false 
#    t.integer "category_id", null: false
#  end
#
# By default, the name of the join table comes from the union of the first
# two arguments provided to create_join_table, in *alphabetical* order. 
# 
class CreateJoinTableProductCategory < ActiveRecord::Migration[5.1]
  def change
    # To customize the name of the table, provide a :table_name option:
    #   create_join_table :products, :categories, table_name:categorization do |t|

    create_join_table :products, :categories do |t|
      # t.index [:product_id, :category_id]
      # t.index [:category_id, :product_id]
    end
  end
end
