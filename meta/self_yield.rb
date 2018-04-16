# coding: utf-8
# ruby

class Job
  attr_accessor :data, :status

  def process
    yield self # self is j below, it works like a block with an additional parameter
  end
end

job = Job.new.process { |j|
  j.data = "data from db"
  puts "processing #{j.data}"
  puts "#{j.data} has been processed."
  j.status = 'Done'
  j # must return the current object, j
}

puts job.status # => Done
