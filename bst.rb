class Node

    attr_accessor :data :left :right

    def initialize(data = nil, left = nil, right = nil)
        @data = data
        @left = left
        @right = right
    end

end

class Tree
    attr_accessor :root

    def initialize
        @root = build_tree(arr)
    end

    def build_tree(arr)
        #turns arr into a balanced BST of Node obj
        return if arr.empty?
       
        result = arr.sort.uniq

        mid = arr.length / 2
        root = Node.new(result[mid])
        root.left = build_tree(result[0...mid])
        root.right = build_tree(result[mid+1..-1])
        root
        
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def insert(value, node = root)
        return Node.new(value) if node.nil?

        if node.value > value
            node.left = insert(value, node.left) 
        elsif node.value < value
            node.right = insert(value, node.right)
        end
        node
    end

    def remove(value, node = root)
        return node if node.nil?

        if node.value > value
            node.left = remove(value, node.left)
        elsif node.value < value
            node.right = remove(value, node.right)
            #if one of the children is empty
        else
            return node.left if node.right.nil?
            return node.right if node.left.nil?

            temp = node
            node
            #need to continue
        end
        node
    end

    def find(value, node = root)
      return node if node.nil? || node.value == value

      if node.value > value
        find(value, node.left)
      elsif node.value < value
        find(value, node.right)
      end
    end

    def level_order(node = root)
      return nil if node.nil?

      queue = [node]
      result = []

      while queue.any?
        current_node = queue.shift
        result << current_node
        queue << current_node.left unless current_node.left.nil?
        queue << current_node.right unless current_node.right.nil?
      end
      result
    end

    def inorder(node = root, result = [])
        #left root right
        return result if node.nil?

        inorder(node.left, result)
        result << node.value
        inorder(node.right, result)

        result 
    end

    def preorder(node = root, result = [])
        #root left right
        return result if node.nil?

        result << node.value
        preorder(node.left, result)
        preorder(node.right, result)

        result
    end

    def postorder(node = root, result = [])
        #left right root
        return result if node.nil?

        postorder(node.left, result)
        postorder(node.right, result)
        result << node.value
    
        result
    end

    def height(node = root)
        return -1 if node.nil?

        left_height = height(node.left)
        right_height = height(node.right)
        left_height > right_height ? left_height + 1 : right_height + 1 
    end

    def depth(node, key, level = 0)
        return level if node.nil?

        curr_node = @root
        count = 0

        until curr_node.data == node.data
            count += 1
            curr_node = curr_node.left if node.data < curr_node.data
            curr_node = curr_node.right if node.data > curr_node.data
        end
        count
    end

    def balanced?
        left_height = height(@root.left, 0)
        right_height = height(@root.right, 0)

        (left_height - right_height).between?(-1, 1)


    end

    def rebalance
        @root = build_tree(level_order)
    
    end

end


tree = Tree.new(Array.new(15) {rand(1..100)})
puts tree.balanced?
puts tree.inorder
puts tree.preorder
puts tree.postorder
puts tree.level_order
tree.insert()
puts tree.balanced?
tree.rebalance
puts tree.balanced?
