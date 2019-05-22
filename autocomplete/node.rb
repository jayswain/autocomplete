module Autocomplete
  class Node
    attr_reader :value
    attr_accessor :frequency, :children

    def self.find_parent(node:,tree:)
      tree.find_child(node.value[0, node.value.length - 1]) || tree
    end

    def initialize(value: nil, frequency: nil)
      @value = value
      @frequency = frequency
      @children = {}
    end

    ##finds a nested node
    #eg from "foobar" to f => fo => foo => foob..
    def find_child(value)
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
end
