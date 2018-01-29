# coding: utf-8
# ruby

# random number
# use an entropy source provided by OS as a random(ish) seed
# the series of numbers are different each time the program is run
3.times do
  p rand
end

p "use constant seed"
# the series of numbers are the same each time the program is run
srand 23 # set a constant seed (before calling rand)
3.times do
  p rand
end


# file read
File.open("random.txt", "r+").readlines.each_with_index do |line, i|
  # r+ => mode (read and write)
  # readlines returns the lines in an array
  line[0, 0] = "#{i + 1}: " # string[start, length]
  p line.class # => String
  p line # => "3: 0.7654597593969069\r\n" (when i = 2)
end

# file write
File.open("random.txt", "r+") do |f|
  lines = f.readlines
  lines.each_with_index { |line, i| line[0, 0] = "#{i + 1}: " }
  f.rewind # positions f to the beginning of input, resetting lineno to zero
  f.puts lines # writes lines to file io stream
end

p File::SEPARATOR # "/" on Windows


# one line script for editing file in-place (add line numbers to a file)
# ruby -i.bak -ne 'print "#$.: #$_"' random.txt

# ruby [switches] [--] [programfile] [arguments]
#  -i[extension] => edit ARGV files in place (make backup if extension supplied) (random.txt.bak)
#    ARGV => command line arguments (in an array) when script is run
#  -n => assume 'while gets(); ... end' loop around your script
#  -e 'command' => one line of script. Several -e's allowed. Omit [programfile]
#  $. => The current input line number of the last file that was read
#  $_ => The last input line of string by gets or readline
#  gets => Returns (and assigns to $_) the next line from the list of files in
#    ARGV (or $*), or from standard input if no files are present on the command line.
#    Returns nil at end of file.

p ARGV # => ["test"] if run with 'ruby library.rb test'
p ARGV.class # => Array


# file copy, buffered I/O, and flush
require "fileutils"
File.open("file.txt", "w").puts "This is a file"
# content is buffered but not flushed (content hasn't been written to disk yet),
# so it might be empty. Why it's not flushed? Because File.open without associated 
# block is a synonym for ::new, which only opens the file.

FileUtils.cp("file.txt", "newfile.txt")
# so newfile.txt might also be empty at this point and
# nothing will be written to disk when the program terminates


# use optional block when open a file
File.open("afile.txt", "w") { |f| f.puts "This is another file." } # f object will be automatically closed when the block terminates

# now file.txt is closed and has the content
FileUtils.cp("afile.txt", "anewfile.txt")


# $. lineno and ARGF
p ARGF.class # => ARGF.class
p ARGF.class.ancestors # => [ARGF.class, Enumerable, Object, Kernel, BasicObject]

p ARGF.file # => #<IO:<STDIN>>


# use less to display file content
# open("|less", "w") { |f| f.puts "abc" } # press q to exit less


# ensure file is always closed (use block)
# (1)
f = File.open("afile.txt")
begin
  f.each {|line| print line}
ensure
  f.close
end

# (2)
File.open("afile.txt") do |f|
  f.each {|line| print line}
end

# (3)
File.foreach("afile.txt") {|line| print line}

# (4)
File.readlines("afile.txt").each {|line| print line}


# file modification time
p File.mtime("afile.txt") # => 2018-01-28 22:59:14 +0800

# sort files by modification time
files = Dir.glob("*") # glob is a bash term meaning filename expansion
p files.class # => Array
p files # ["file.txt", "prll_iter.rb", ..., "anewfile.txt", "afile.txt"]

# this approach is inefficient as File.mtime is called on every comparison
p files.sort {|a, b| File.mtime(b) <=> File.mtime(a) }

# better to get the modification time first before sorting
p files.map {|f| [File.mtime(f), f] }.sort {|a, b| b[0] <=> a[0] }.map(&:last)

a = files.map {|f| [File.mtime(f), f] } # map to a 2D array with elements of subarraies [File.mtime(f), f]
p a # [[2018-01-28 22:25:20 +0800, "file.txt"], ..., [2018-01-28 22:25:20 +0800, "afile.txt"]]

as = a.sort {|a, b| b[0] <=> a[0] } # sort
p as # [[2018-01-28 22:28:04 +0800, "anewfile.txt"], ..., [2018-01-16 22:30:22 +0800, "Person.rb"]]

am = as.map(&:last) # map to an array, using the last element of the subarraf as the element (this is called pretzel style in Ruby community)

p am # ["anewfile.txt", "afile.txt", ..., "persons.txt", "Person.rb"]

amm = as.map {|a| a.last} # this is the general style of as.map(&:last)
p amm # ["anewfile.txt", "afile.txt", ..., "persons.txt", "Person.rb"]

p am == amm # => true

# &:symbol (pretzel colon) 
a1 = (1..5).to_a
a2 = (6..10).to_a
a3 = (11..20).to_a
aa = [a1, a2, a3]

p aa.map(&:first) # => [1, 6, 11]
p aa.map(&:length) # => [5, 5, 10]


# count the frequency of words in a file
freq = Hash.new(0) # Hash#new(default) 0 will be returned when accessing keys do not exist in the hash
File.read("words.txt").scan(/\w+/) { |word| freq[word] += 1 }
freq.keys.sort.each { |word| puts "#{word}: #{freq[word]}" }

# File.read is an implementation from IO
#   IO.read(file_name) -> string
# Opens the file, read and reurns the content as a string.
# read ensures the file is closed before returning.
#
# String.scan
#   str.scan(pattern)                         -> array
#   str.scan(pattern) {|match, ...| block }   -> str
#     pattern may contain groups, thus multiple matches are possible in |match, ...|. E.g. a.scan(/(..)(..)/) )
# scan(/\w+/) {...} returns matches in an array, then passes it to the associate block 


# sort strings in alphabetical order
alp = ('a'..'f').to_a
p alp # => ["a", "b", "c", "d", "e", "f"]
p alp.sort {|a,b| b <=> a} # => ["f", "e", "d", "c", "b", "a"]

mixed = alp.each_with_index.map {|a, i| i % 2 == 0 ? a.upcase : a}
p mixed # => ["A", "b", "C", "d", "E", "f"]
p mixed.sort {|a,b| b <=> a} # => ["f", "d", "b", "E", "C", "A"]
p mixed.sort {|a,b| b.upcase <=> a.upcase} # => ["f", "E", "d", "C", "b", "A"] (ignore case distinctions, there is also downcase)
p mixed.sort {|a,b| b.downcase <=> a.downcase}


# nonzero?
#   Returns self if the value is non-zero, nil otherwise.
p 1.nonzero? # => 1 
p 0.nonzero? # => nil


# string.sub and string.gsub
s = "i love ruby!"
p s.sub(/(\b[a-z])/) { "#{$1.upcase}" } # => "I love ruby!"
# sub replace only the first occurrence, $1 is back-reference to the pattern group (\b[a-z]) 
s.gsub!(/(\b[a-z])/) { |match| match.upcase } # global substitution
p s # => "I Love Ruby!"

t = "u9304yf bp4y0349pg"
p t.gsub(/([a-z])(\d{4})/) { |match| "#{$1.upcase + $2 + $1.upcase}"} # match is $&

p $& # => string last matched by regexp ("y0349")
p $~, $~.class # => (#<MatchData "y0349" 1:"y" 2:"0349">) (note the index starts from 1)
#   the last regexp match of type MatchData with subexpressions (pattern groups) 
p $1, $~[1] # => $n -> the nth subexpression (pattern group) in the last match (same as $~[n]) ("y")
p $+, $~[2] # => the last group of the last match (last element of $~). ("0394")

p $` # => $PREMATCH -> The string to the left of the last match ("u9304yf bp4")
p $' # => $POSTMATCH -> The string to the right of the last match ("pg")


# \Z, matches the end of the string (not line)
# there are also \A which matches the start of the string
# besides, ^ and $ match the start and end of the line respectively
zz = "I\nlove\nRuby"
p zz.sub(/\Z/, '!') # => "I\nlove\nRuby!"


# Marshal
m = File.new("marshal.txt", "r+")
Marshal.dump(freq, m) # store an object in a file (m must be writable)

m.rewind # go back to the beginning of the file stream
ff = Marshal.load(m) # load object back (m must be readable)
p ff

# dump to string (omitting the io parameter)
ms = Marshal.dump(freq)
p ms
ff = Marshal.load(ms)
p ff
