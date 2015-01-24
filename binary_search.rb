class Tree
	attr_reader :tree, :root
	def initialize(array)
		@root = nil
		@tree = build_tree_unsorted(array)
	end

	def build_tree_unsorted(array)
	
		nodes = []

		array.each_with_index do |num, i|
			node = Node.new(num)
			if i > 0
				compare_node = @root
				
				done = false
				#loop until node placed
				until done
					#look at node less than current
					if compare_node.value > node.value
						
						#if node does not have a left child set child and parent, set to done
						if !compare_node.children[:left]

							compare_node.children[:left] = node
							node.parent = compare_node
							nodes << node
							done = true
						#if node has a left child set new compare node
						else
							compare_node = compare_node.children[:left]
						end


					#look at node greater than current
					elsif compare_node.value < node.value

						#if node does not have a right child set child and parent, set to done
						if !compare_node.children[:right]
							compare_node.children[:right] = node
							node.parent = compare_node
							nodes << node
							done = true

						#if node has a left child set new compare node
						else
							compare_node = compare_node.children[:right]
						end								
					#if not < or > means same, no duplicate nodes according to wikipedia
					else
						done = true
					end				
				end			


			else
				if i == 0 
					@root = node
					nodes << @root
				end
			end
		end

		nodes

	end

	def breadth_first_search(value)
		return @root if @root.value == value
		queue = []
		found = false
		current_node = @root
		until found
			queue.push(current_node.children[:right]) if current_node.children[:right] != nil
			queue.push(current_node.children[:left]) if current_node.children[:left] != nil
			if queue == []
				return nil
			elsif queue[0].value == value
					return queue[0]
			else
				current_node = queue.shift
			end
		end

		
	end

	def depth_first_search(value)
		return @root if @root.value == value
		stack = []
		found = false
		current_node = @root
		until found
			stack.push(current_node.children[:right]) if current_node.children[:right] != nil
			stack.push(current_node.children[:left]) if current_node.children[:left] != nil
			if stack == []
				return nil
			elsif stack[-1].value == value
				return stack[-1]
			else
				current_node = stack.pop
			end
		end
	end

	def dfs_rec(value, current = @root)
#		puts "#{value}, #{current.value}"
		return current if current.value == value
		dfs_rec(value, current.children[:left]) if current.children[:left] != nil
		dfs_rec(value, current.children[:right]) if current.children[:right] != nil
	end

end

class Node
	attr_accessor :value, :children, :parent

	def initialize(value, parent = nil, children = {left: nil, right: nil})
		@value = value
		@children = children
		@parent = parent
	end

	def to_s
#		output = ""
		"value: #{@value.to_s}, parent: #{@parent == nil ?  'none' : @parent.value} left child: #{@children[:left]  == nil ?  'none' : @children[:left].value}, right child: #{@children[:right]  == nil ?  'none' : @children[:right].value}" 
	end
end



def build_tree_sorted(array)

	 nodes = [] 
	 array.each_with_index do |num, i|
	 	left_child = array.length == i + 1 ? nil : nil

	 	right_child = array.length == i + 1 ? nil : array

	 	parent = nodes[-1] if i != 0

	 	node = Node.new(num, parent )

	 	nodes[-1].children[:right] = node if i != 0

	 	nodes << node

	 end
	 nodes
end



test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

test.tree.each do |node|
	puts node.to_s
end

puts test.dfs_rec(6345)
puts test.dfs_rec(666).nil?


