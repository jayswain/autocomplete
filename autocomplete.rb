puts "parsing text"

text = File.read(ARGV[0])

puts "got text"

class Node
  attr_reader :value
  attr_accessor :frequency, :children

  def initialize(value: nil, frequency: nil)
    @value = value
    @frequency = frequency
    @children = {}
  end

  ##finds a nested node
  #eg from "foobar" to f => fo => foo => foob..
  def find_node(value)
    node = nil
    nodes = children
    i = 0

    while i < value.length
      slice = value[0, i + 1]
      if slice == value
        node = nodes[slice]
        break
      else
        nodes = nodes[slice].children
      end
      i += 1
    end

    node
  end

  def suggestions(nodes=children, results=[])
    nodes.each do |node_hash|
      node = node_hash[1]
      results.push(node) if node.frequency
      suggestions(node.children, results)
    end

    results.sort{ |a,b| b.frequency <=> a.frequency }[0, 25]
  end
end

puts "parsing words"

words = text.downcase.gsub(/[^a-zA-Z0-9\s]/i, '').split(" ")

puts "building freq hash"

word_frequency_hash = words.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }

puts "building tree"

tree = Node.new

words.uniq.each do |word|
  i = 0

  while i < word.length
    slice = word[0, i + 1]
    exists = tree.find_node(slice)

    if exists
      if slice == word && exists.frequency.nil?
        exists.frequency = word_frequency_hash[word]
      end
    else
      freq = slice == word ? word_frequency_hash[word] : nil
      parent = tree.find_node(slice[0, slice.length - 1])
      node = Node.new(value: slice, frequency: freq)
      if parent
        parent.children[slice] = node
      else
        tree.children[slice] = node
      end
    end

    i+= 1
  end
end

fragments = ["th", "fr", "pi", "sh", "wu", "ar", "il", "ne", "se", "pl"]

fragments.each do |fragment|
  puts "-" * 50
  puts "Suggestions for #{fragment}"
  puts "-" * 50
  results = tree.find_node(fragment).suggestions
  results.each{ |node| puts "#{node.value} (#{node.frequency})" }
end

puts "done"
