# bin/rails g migration AddDetailsToProducts 'price:decimal{5,2}' user:references
# user:references will create a new column user_id and mark it as foreign_key
# referencing user table's primary key (id).
#
# type modifiers (also called column modifiers):
# {5,2} in 'price:decimal{5,2}' has two type modifiers (precision and scale
# as called in a database context) for column type decimal. The data in price
# column will be in this format: 123.45
#
# references type also has modifiers, for example
# user:references will add an user_id column and mark it as foreign_key.
# like this:
#     t.integer "user_id"
#     t.index ["user_id"], name: "index_products_on_user_id"
#
# (check schema.rb for details)
# 
class AddDetailsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :price, :decimal, precision: 5, scale: 2
    # => add_column(:products, :price, :decimal, {:precision=>5, :scale=>2})
    
    add_reference :products, :user, foreign_key: true
    # => add_reference(:products, :user, {:foreign_key=>true})
    
  end
end
