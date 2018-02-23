# coding: utf-8
# ruby

# Quote, long text and heredocs
name = "James"

# %q is similar to single quote '...'
puts %q{Me: "Hi! I'm #{name}."
You: "Hi! Im Ruby."
}

# %Q is similar to double quote '...'
# note the delimiter can be other characters ((), [], ||, ^^, //)
puts %Q[Me: "Hi! I'm #{name}."
You: "Hi! Im Ruby."
]

puts %Q/#{name} loves Ruby!/

# heredoc
# XXX can be any continuous random string without symbol when used without double quote
# Valid examples are AAA, ABC123, ZZZZZZZZ
# Anything other than letters and numbers are invalid ($$$$$, ?????, #####)
# Also, Ruby variables and expressions are evaluated.
dd = <<ABC123
Write your 'essay' here.
Compose your "opus" here.

        My dear Ruby!
        How I love you!

    #{name}
ABC123
# Note the terminating sequence(ABC123) +must+ be at the very beginning of the line

# Use double quote for any character sequence
dd = <<"!@#$%^&*(){}"
this is a poem
     hahaha
     hehehe
by #{name}
!@#$%^&*(){}

puts dd

# Double quote or no quoting interpolates the string
# No interpolating when quoted with single quote
puts <<'NOT_INTERPOLATED'
#{name} is not evaluated.
Ooops!
NOT_INTERPOLATED

# <<- and <<~
puts <<-leading
     This line is indented with one tab.
          This is indented with two tabs.
leading

# each line is stripped n number of spaces while n is the minimum of
# leading whitespace of all lines (the least indented line)
puts <<~NoLeading
    Leading whitespace are stripped (4 spaces)
        This line is indented with 8 spaces (4 spaces are stripped)
          This is indented with 10 spaces (4 spaces are stripped)
NoLeading

### String operation
puts "I love Ruby!\n" * 3


# for loop, next and break
for x in 1..9 do
  if x % 3 == 0 then next end # skips 3,6,9 (next is similar to continue)
  if x % 2 == 0 then print x end
end

# array (aka list)
ll = (1..9).to_a
ll[3,4] = Array.new(3, 8) # replace 4 elements of array to a new array, starting at index 3
p ll # [1, 2, 3, 8, 8, 8, 8, 9]


## loop through array (list)
ll.each_with_index { # opening curly bracket must be on this line, else syntax error.
  |x, index|
  p "ll[#{index}] => #{x}"
}

## hash table loop
hh = {:james => 30, :russel => 6}
hh.each {
  |kk, vv| # key and value
  p "#{kk} => #{vv}"
}


### Map function to array
def incr(x) x + 1 end
nll = ll.map {|xx| incr xx} # apply incr function to each element and return a new array
p ll
p nll

mll = ll.map! {|xx| incr xx} # apply incr function to each element of the array and returns the original array (ll and mll are the same object)
p ll
p mll

mll[0] = 111
p ">> #{ll[0]}"

## select/filter elements by condition
lll = mll.select { |xx| xx % 2 == 0 } # selects and returns a new array
p mll
p lll

mll.select! { |xx| xx % 2 == 0 } # filter and remove elements from the original array
p mll

