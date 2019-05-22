require_relative './node'

module Autocomplete
  class Tree
    def initialize(text:)
      @words = text.downcase.gsub(/[^a-zA-Z0-9\s]/i, '').split(" ")
      @tree = Autocomplete::Node.new
      create_nodes!
    end

    def suggestions(fragment)
      @tree.find_child(fragment).suggestions
    end

    private

    def create_nodes!
      @words.uniq.each do |word|
        i = 0

        while i < word.length
          slice = word[0, i + 1]
          slice_is_word = slice.length == word.length

          exists = @tree.find_child(slice)

          if exists
            if slice_is_word && exists.frequency.nil?
              exists.frequency = word_frequency_hash[word]
            end
          else
            frequency = slice_is_word ? word_frequency_hash[word] : nil
            node = Node.new(value: slice, frequency: frequency)
            parent = Node.find_parent(node: node, tree: @tree)
            parent.children[slice] = node
          end

          i+= 1
        end
      end
    end

    def word_frequency_hash
      @word_frequency_hash ||= @words.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
    end
  end
end
