# coding: utf-8
# ruby

p "#{$0} is using #{__ENCODING__}" # prints #<Encoding:UTF-8>

p "I ♥ Ruby"
p "I ♥ Ruby".encoding
p "I ♥ Ruby".encoding.class # Encoding
p "I ♥ Ruby".encoding.name # UTF-8
p "I ♥ Ruby".size # 8 characters
p "I ♥ Ruby".bytesize # 10 bytes (♥ is 3 bytes in utf-8)

# change encoding
heart = "♥"
heart.force_encoding("GB2312") # changes the encoding meta-data of the string object
p heart  # "\xE2\x99\xA5"


# default encoding of Ruby strings is from your source code encoding (this is
# called internal_encoding), but when open a file you can specify another
# encoding (this is called external_encoding)
f = File.open("i_heart_ruby.txt") # use source code encoding (__ENCODING__)
f.each {|line| p line}
f = File.open("i_heart_ruby.txt", "r:utf-8") # tells Ruby the encoding of the file (r: means read, use w: for writing out to a file)
f.each {|line| p line}

# tells Ruby the encoding of the file (utf-8) and
# the encoding to use when Ruby decodes the content of that file (utf-16)
f = File.open("i_heart_ruby.txt", "r:utf-8:utf-16")
p f.external_encoding.name # utf-8
p f.internal_encoding.name # utf-16

ln = f.readline
p ln.encoding.name # utf-16
p ln # "\uFEFFI \u2665 ruby.\r\n" (prints in utf-16)

# All encodings Ruby supports
Encoding.list.each { |e| p e.name }
