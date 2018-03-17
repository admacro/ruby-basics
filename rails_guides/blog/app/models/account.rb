class Account < ApplicationRecord
  # another name for :in is :within
  validates :subdomain, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }
  # %w(foo bar #{1+1}) == ["foo", "bar", "\#{1+1}"]
  # %W(foo bar #{1+1}) == ["foo", "bar", "2"] # capitalized

  # contrary to exclusion, inclusion validates that the field value is in a given set
  validates :subdomain, inclusion: { in: %w(blog admin portfolio), message: "%{value} is not a subdomain"}
end
