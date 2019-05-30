require_relative './node'

module Autocomplete
  class Parser
    def self.parse(*args)
      instance = self.new(*args)
      instance.create_nodes!
    end

    def initialize(text:, root_node:)
      @words = text.downcase.gsub(/[^a-zA-Z0-9\s]/i, '').split(" ")
      @root_node = root_node
    end

    def create_nodes!
      @words.uniq.each do |word|
        word.split("").each_with_index do |letter, index|
          is_the_word = (index == (word.length - 1))
          nested_keys = word[0, index + 1].split("")
          existing_node = @root_node.dig(*nested_keys)

          node = existing_node || Node.new
          if is_the_word
            node.frequency = word_frequency_hash[word]
            node.value = word
          end

          if !existing_node
            nested_keys.pop
            (@root_node.dig(*nested_keys) || @root_node).children[letter] = node
          end
        end
      end
    end

    private

    def word_frequency_hash
      @word_frequency_hash ||= @words.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
    end
  end
end
