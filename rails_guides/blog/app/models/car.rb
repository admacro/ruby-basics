class Car < ApplicationRecord

  # The has_one association sets up a one-to-one connection with another model (Engine).
  # In the database, the connection between the two models is backed up by a foreign key 
  # referencing the id of the defining model (Car). 
  has_one :engine
  
end
