# coding: utf-8
# ruby

# using requires resource
def using(resource)
  # this can be enhanced to have a better error handling
  # for example, raise error when resource doesn't have dispose method
  if resource != nil && resource.respond_to?('dispose') && block_given?
    begin
      yield
    ensure
      resource.dispose
    end
  end
end
