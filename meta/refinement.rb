# coding: utf-8
# ruby

# Refinement @p38
# 
# It seems that refinement is less powerful when compared to monkeypatch for
# patching or extending a class. It only guarantees the effect of the refined methods.
# You cannot get the same effect when calling a unrefined method which calls your
# refined method.
#
# In other words, while monkeypatch has butterfly effect (sensitive and implicit), 
# refinement has restricted/local effect only on cases to which the refined methods are
# applied/called explicitly.
#
# To summarize,
#   Monkeypatch => change one method, affect the method itself and other methods which reference it
#   Refinement => change one method, affect only the method itself in a certain scope.
#     scope => where it's used explicitly and in the refined class
#
class Essay
  def title
    'draft title'
  end

  def content
    'draft content'
  end

  def output
    "#{title} and #{content}"
  end
end

module RefinedEssay
  refine Essay do    
    def content
      'refined content'
    end
  end
end

using RefinedEssay
# unrefined methods call unrefined methods as they are not part of the refined class,
# so they can't see the refined methods.
puts Essay.new.output # => draft title and draft content


module RefinedEssay
  refine Essay do
    def output
      "#{title} and #{content}"
    end
  end
end

using RefinedEssay
# refined methods look for methods first in the refined class, and use the refined
# version if found; otherwise go back to the unrefined class for the unrefined methods.
puts Essay.new.output # => draft title and refined content


module RefinedEssay
  refine Essay do
    def title
      'refined title'
    end
  end
end

# all methods are refined at this point
using RefinedEssay
puts Essay.new.output # => refined title and refined content
