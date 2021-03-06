module Arel
  module Nodes
    ###
    # Abstract base class for all AST nodes
    class Node
      ###
      # Factory method to create a Nodes::Grouping node that has an Nodes::Or
      # node as a child.
      def or right
        Nodes::Grouping.new Nodes::Or.new(self, right)
      end

      ###
      # Factory method to create an Nodes::And node.
      def and right
        Nodes::And.new self, right
      end

      # FIXME: this method should go away.  I don't like people calling
      # to_sql on non-head nodes.  This forces us to walk the AST until we
      # can find a node that has a "relation" member.
      #
      # Maybe we should just use `Table.engine`?  :'(
      def to_sql engine = Table.engine
        viz = Visitors.for engine
        viz.accept self
      end
    end
  end
end
