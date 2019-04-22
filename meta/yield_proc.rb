class YieldProc
  def x
    send :a, 1, 2
    send :b, 2, 3
  end

  def xx
    puts '<xx'
    yield
    puts 'xx>'
  end

  def a(a, b)
    puts '<a'
    xx { Proc.new { aa(a, b) }.call }
    puts 'a>'
  end

  def aa(a, b)
    puts "#{a}-#{b}"
  end

  def b(b, c)
    puts '<b'
    xx { Proc.new { bb(b, c) }.call }
    puts 'b>'
  end

  def bb(b, c)
    puts "#{b}-#{c}"
  end
end
YieldProc.new.x
