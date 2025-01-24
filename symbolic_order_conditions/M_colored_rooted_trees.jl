# Generates the level sequence, color sequence, and density of all
#   NPRK trees, i.e., ARK trees with fixed root coloring (0),
#   	for input: partitions >= 1
#   	for input: order >= 1
# 	and outputs these to a csv, where each row is a tree
# The code requires RootedTrees.jl and DelimitedFiles
using RootedTrees
using DelimitedFiles

print("Enter the number of partitions \n\n")
partitions = parse(Int64,readline())
print("Enter the order \n\n")
order = parse(Int64,readline())
output = Array[]

if order == 1
	# if order is 1, generate trivial tree with fixed root color 0
	trivialtree = rootedtree([1],[0])
	append!(output,Array[[trivialtree.level_sequence; trivialtree.color_sequence; density(trivialtree) ]])
else
	# else order > 1
	# Generate all possible color sequences with colorings 0,1,...,partitions-1
	# 	of length order-1 (minus one because the root coloring is fixed to 0)
	colors = reverse.(Iterators.product(fill(0:partitions-1,order-1)...))[:]
	
	# Loop over all uncolored rooted trees and append the above color sequences
	# 	to define colored rooted trees
	# Appends each colored rooted tree as a row to output
	# Note that this will generate duplicate trees that are isomorphic
	for a in RootedTreeIterator(order)
		for c in colors
			colorseq = collect((0,c...))
			t = rootedtree(a.level_sequence,colorseq)
			append!(output,Array[[t.level_sequence; t.color_sequence; density(t) ]])
		end
	end
end

# remove isomorphic trees
output = unique(output,dims=1)

# write output to csv
writedlm("M$(partitions)_output$(order).csv",output,',')