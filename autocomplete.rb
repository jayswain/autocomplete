require './autocomplete/node'
require './autocomplete/parser'

text = ARGF.read

root_node = Autocomplete::Node.new
Autocomplete::Parser.parse(text: text, root_node: root_node)

fragments = %w(th fr pi sh wu ar il ne se pl)

fragments.each do |fragment|
  puts "-" * 50
  puts "Suggestions for #{fragment}"
  puts "-" * 50

  results = root_node.suggestions(fragment: fragment)
  results.each{ |node| puts "#{node.value} (#{node.frequency})" }
end
