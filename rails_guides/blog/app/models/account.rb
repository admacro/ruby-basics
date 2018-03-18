class Account < ApplicationRecord
  # another name for :in is :within
  validates :subdomain, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }
  # %w(foo bar #{1+1}) == ["foo", "bar", "\#{1+1}"]
  # %W(foo bar #{1+1}) == ["foo", "bar", "2"] # capitalized

  # contrary to exclusion, inclusion validates that the field value is in a given set
  validates :subdomain, inclusion: { in: %w(blog admin portfolio), message: "%{value} is not a subdomain"}

  # make sure we don't have any fines
  # absence validation makes sure the field is blank or nil
  # it uses present? method to check if the value is absent (nil or blank)
  # when checking the associated object, marked_for_deconstruction? will also be used
  # when validating absence of a boolean field, you should not use absence. Instead, 
  # you should use exclusion: {in: [true, false]}, similar with :presence 
  validates :fines, absence: true

  # This uniqueness check is application level, meaning it's possible that two 
  # different database connections create two records with the same value for a
  # column that you intend to be unique. To avoid that, you must create a unique
  # index on that column in your database.
  #
  # When use :uniqueness with :scope option, an index of multiple columns is
  # required in your database
  validates :domain, uniqueness: { scope: :subdomain, message: "should be only one per subdomain"}

end
