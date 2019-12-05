s = "outer"
p s.object_id

loop do
  p s

  s = "inner"
  p s.object_id
  p s

  break
end

p s
