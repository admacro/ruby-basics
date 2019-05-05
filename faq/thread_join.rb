
def time_now
  Time.now.to_f.to_s
end

def join_thread(y)
  puts time_now << ' > join... '
  # join(limit)
  # If the time limit(seconds) expires, nil will be returned, otherwise y is returned.
  y.join(0.15)
end

def run
  puts time_now

  y = Thread.new do
    4.times do |i|
      puts time_now
      sleep 0.1
      puts time_now << ' > tick... '
    end
  end

  # As there is no additional time consuming code between the above and the
  # following code, the following code will be excuted ahead of the actual
  # excution of y thread.
  # The time gap (about 0.138ms) betwen the excution of the above and the
  # following code is less than the initialization time (0.236ms) of the
  # above code before it actually runs.
  until join_thread(y) do
    puts time_now << " > Waiting"
  end
end

run
