# coding: utf-8
# ruby

def palindrome?(sentence)
  if sentence.nil? || sentence.length == 0
    return false
  end
  
  sa = sentence.chars.select! {|c| c != " "}
  len = sa.length
  llen = len % 2 == 0 ? len / 2 : (len - 1) / 2
  (0..llen).to_a.each { |i|
    if sa[i] != sa[len - i - 1]
      false
    end
  }
  true
end

puts palindrome? "Never odd or even"
puts palindrome?("Race fast safe car")
puts palindrome? "Live not on Evil"
puts palindrome? "Yreka Bakey"
puts palindrome? ""
puts palindrome? nil
