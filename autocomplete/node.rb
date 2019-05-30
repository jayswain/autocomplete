module Autocomplete
  class Node
    attr_accessor :frequency, :children, :value

    def initialize(value: nil, frequency: nil)
      @value = value
      @frequency = frequency
      @children = {}
    end

    def suggestions(fragment: nil, nodes: children, results: [])
      if fragment
        nested_keys = fragment.split("")
        dig(*nested_keys).suggestions
      else
        nodes.each do |_, node|
          results.push(node) if node.frequency
          suggestions(nodes: node.children, results: results)
        end

        results.sort{ |a,b| b.frequency <=> a.frequency }[0, 25]
      end
    end

    def dig(*args)
      return nil if args.empty?
      children.dig(*args)
    end
  end
end
