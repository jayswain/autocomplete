require './autocomplete/tree'

text = File.read(ARGV[0])
tree = Autocomplete::Tree.new(text: text)

fragments = %w(th fr pi sh wu ar il ne se pl)

fragments.each do |fragment|
  puts "-" * 50
  puts "Suggestions for #{fragment}"
  puts "-" * 50

  results = tree.suggestions(fragment)
  results.each{ |node| puts "#{node.value} (#{node.frequency})" }
end
