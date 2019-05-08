# coding: utf-8
# ruby

# Running multiple iterators in parallel - a solution using threads by Matz
# http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/5252

require "thread"

def combine(*iterators)
  queues = []
  threads = []

  iterators.each do |it|
    queue = SizedQueue.new(1)

    # Thread.new(*args) {}
    # Any args given to ::new will be passed to the block.
    # A ThreadError exception is raised if ::new is called without a block.
    th = Thread.new(it, queue) do |i, q| # i is iter, q is queue
      # send(:symbol [, args...])
      # Invokes the method identified by symbol, passing it any arguments specified.
      # i is method it1 and it2
      send(i) {|x| q << x } # invokes i, pasing {|x| q << x } as proc to i
    end
    queues  << queue
    threads << th
  end

  loop do
    ary = []
    queues.each {|q| ary << q.pop }
    yield ary # this executes the block associated with combine invocation

    iterators.size.times do |i|
      # Thread#status -> string ("sleep", "run", "aborting"), false or nil
      # false -> When this thread is terminated normally
      # nil -> If terminated with an exception
      return if !threads[i].status && queues[i].empty?
    end
  end
end


if $0 == __FILE__
  def it1
    # yield 1; yield 2; yield 3 # calls {|x| q << x } associated with send(i) above
    (1..5).each { |x| yield x} # calls {|x| q << x } associated with send(i) above
  end

  def it2
    # yield 4; yield 5; yield 6 # calls {|x| q << x } associated with send(i) above
    (6..10).each { |x| yield x} # calls {|x| q << x } associated with send(i) above
  end

  combine(:it1, :it2) do |x|
    # [1, 6]
    # [2, 7]
    # [3, 8]
    # [4, 9]
    # [5, 10]
    p x
  end


  def it3
    # yield 4; yield 5; yield 6 # calls {|x| q << x } associated with send(i) above
    (11..15).each { |x| yield x} # calls {|x| q << x } associated with send(i) above
  end

  combine(:it1, :it2, :it3) do |x|
    # [1, 6, 11]
    # [2, 7, 12]
    # [3, 8, 13]
    # [4, 9, 14]
    # [5, 10, 15]
    p x
  end

end 
