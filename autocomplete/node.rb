module Autocomplete
  class Node
    attr_accessor :frequency, :children, :value

    def initialize(value: nil, frequency: nil)
      @value = value
      @frequency = frequency
      @children = {}
    end

    def suggestions(nodes=children, results=[])
      nodes.each do |key, node|
        results.push(node) if node.frequency
        suggestions(node.children, results)
      end

      results.sort{ |a,b| b.frequency <=> a.frequency }[0, 25]
    end

    def dig(*args)
      return nil if args.empty?
      children.dig(*args)
    end
  end
end
