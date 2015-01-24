
class Node
	attr_accessor :value, :children, :parent

	def initialize(value, parent = nil, children = [])
		@value = value
		@children = children
		@parent = parent
	end

	def add_child(child)
		@children.push(child)
	end

	
end

def knight_moves(start, finish)
	#breadth first
	done = false
	#Build as nodes to be able to trace path form start to finish
	current = Node.new(start)
	queue = []
	until done
		#Put this in a method to reduce redundancy?
		#For each possible movement, check if legal on board and push to queue
		#As long as node is not what we are looking for
		if current.value != finish
			if current.value[0] < 7 and current.value[1] < 6
				node = Node.new([current.value[0]+1, current.value[1]+2], current)
				current.add_child(node)
				queue.push(node) 
			end

			if current.value[0] > 0 and current.value[1] > 1
				node = Node.new([current.value[0]-1, current.value[1]-2], current)
				current.add_child(node)
				queue.push(node) 
			end

			if current.value[0] < 7 and current.value[1] > 1
				node = Node.new([current.value[0]+1, current.value[1]-2], current)
				current.add_child(node)
				queue.push(node) 
			end

			if current.value[0] > 0 and current.value[1] < 6
				node = Node.new([current.value[0]-1, current.value[1]+2], current)
				current.add_child(node)
				queue.push(node) 
			end

			if current.value[0] < 6 and current.value[1] > 0
				node = Node.new([current.value[0]+2, current.value[1]-1], current)
				current.add_child(node)
				queue.push(node) 
			end

			if current.value[0] > 1 and current.value[1] < 7
				node = Node.new([current.value[0]-2, current.value[1]+1], current)
				current.add_child(node)
				queue.push(node) 
			end			

			if current.value[0] < 1 and current.value[1] < 0
				node = Node.new([current.value[0]-2, current.value[1]-1], current)
				current.add_child(node)
				queue.push(node) 
			end		

			if current.value[0] < 6 and current.value[1] < 7
				node = Node.new([current.value[0]+2, current.value[1]+1], current)
				current.add_child(node)
				queue.push(node) 
			end

			current = queue.shift
		else
			done = true
			finished = current
		end

	end

	output = []
	done = false 
	count = 0
	current = finished.parent
	until done
		output.push(current.value)
		count += 1
		if current.parent 
			current = current.parent
		else
			done = true
		end
	end

	message = "You made it in #{count} moves! Here's your path:\n"
	output.each{|path| message += path.to_s + "\n"}
	message += finished.value.to_s
end

puts knight_moves([3,3],[4,3])
puts knight_moves([1,3],[7,3])