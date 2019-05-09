# coding: utf-8
# ruby

# Trap ^C
Signal.trap("INT") {
  puts "\n Goodby..."
  exit
}

# Trap ^\
# This is on mac. It might be different on other systems.
# Use `stty -a` to list signals and their associated key combo
# Kernel.trap (synonymous with Signal.trap)
trap("QUIT") {
  puts "\nShutting down gracefully..."
  exit
}

sleep 10
