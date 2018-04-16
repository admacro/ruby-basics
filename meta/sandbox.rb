# coding: utf-8
# ruby

# use $SAFE to set security level (p240, 149)
#
# Only two levels are supported in Ruby of version >= 2.3
#   0 => default (no security at all)
#   1 => Ruby will mark objects as tainted in certain cases.
#        For example, reading data from unsecure source, command line, Kernel#gets, ect.
#        Objects that are marked as tainted will be restricted from various built-in methods.
#        If you intend to secure your program, use Object#tainted? to check the status of
#        taint before using the object.
#
# 4 is dropped in 2.1
#
# From Ruby v2.3
# If you assign $SAFE to 2, 3, or 4, you will get an error.
#   => ArgumentError: $SAFE=2 to 4 are obsolete
#
# A detailed explaination of legacy levels can be found here.
#   https://ruby-hacking-guide.github.io/security.html
#
# == NOTE ==
# As per Ruby official doc, $SAFE does not provide a secure environment for
# executing untrusted code. It suggests you use an operating system level 
# sandboxing mechanism if you need to execute untrusted code.

def sandbox
  puts "$SAFE in sandbox => #{$SAFE}" # => 0
  
  # set $SAFE in a lambda execute the block passed in
  lambda {
    $SAFE = 1
    puts "$SAFE in lambda in sandbox => #{$SAFE}" # => 1
    
    yield
  }.call
end

begin
sandbox {
  file_name = gets.chomp
  File.delete file_name 
}
rescue Exception => ex
  puts ex # => Insecure operation - delete (SecurityError)
end

