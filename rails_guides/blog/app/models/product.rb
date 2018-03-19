class PreorderValidator < ActiveModel::Validator
  def validate(record)
    if record.name.downcase.start_with?("preorder")
      # errors added to `:base` relate to the state of the record as a whole, and not
      # to a specific attribute
      record.errors[:base] << "This is a preorder product."
    end
  end
end

class PromotionValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |field|
      field_value = record.send(field) || ""
      if field_value.downcase.include?("promotion")
        record.errors[field.to_sym] << "#{field} has promotion info"
      end
    end
  end
end

# Notes
# Validator will be initialized +only once+ for the whole application life cycle,
# and not on each validation run, so be careful about using instance variables inside it.
#
# If you have to use instance variables, you can use `validate` method in the
# record class and pass it to the validator when you initializ it. See below.
#
# plain old Ruby object (poro?? like pojo in Java? Oh no. What a dissapointment. Bah. )
class ComplexValidator < ActiveModel::Validator
  def initialize(product)
    @product = product
  end
  
  def validate
    # some complex validation here involving ivars and private methods
    # ivars => instance variables
    true
  end
end

# pass `featured: true` to `validates` method to have the field validated by
# the `validate_each` method below.
class FeaturedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.downcase.start_with?("featured") 
      # you need to specify a default error message for validation failure should
      # the :message option is empty
      record.errors[attribute] << (options[:message] || "not a featured product")
    end
  end
end


class Product < ApplicationRecord

  # `validates_with` takes one or more classes, each extends `ActiveModel::Validator`
  # and implements the `validate` method.
  validates_with PreorderValidator, PromotionValidator, fields: [:name, :description]

  # complex validation using instance variables
  validate do |person| # this is the current instance
    ComplexValidator.new(person).validate
  end

  # if existing validation heplers don't offer what you need, you can write your own
  # using `validates_each`.
  #
  # About =~ and /\A[[:lower:]]/
  # =~ is the recommanded operator for regex matching. E.g. "abc123" =~ /?c1\d*/
  # /\A[[:lower:]]/
  #   \A => matches the start of the string. (to match the end of the string, use \z)
  #   [[:lower:]] => Lowercase alphabetical character (this is a POSIX bracket expression)
  #                  see more here (https://ruby-doc.org/core-2.5.0/Regexp.html)
  validates_each :name, :description do |record, attr, value|
    record.errors.add(attr, "must start with upper case") if value =~ /\A[[:lower:]]/
  end

  # `featured: true` will call `FeaturedValidator.validate_each` to validate :name field
  validates :name, featured: { message: "Only featured products are allowed" }

  # validate by calling custom method directly
  # You need to do everything yourself, like checking attribute value and adding
  # error message to errors array, but you have more control over the validation. 
  validate :description_sanity_check
  
  def description_sanity_check
    description ||= ""
    if description.include?("shit")
      errors.add(:description, "shit is not allowed here.")
    end
  end
end
