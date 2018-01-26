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

