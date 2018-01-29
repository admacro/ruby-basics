# coding: utf-8
# ruby

# Trap ^C 
Signal.trap("INT") { 
  puts "\nShutting down gracefully..." 
  exit
}

sleep 10
