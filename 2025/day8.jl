function lineToPoint(line)
	[parse(Int, i) for i in split(line, ",")]
end
function distance(a, b)
	sqrt(sum([(a[i]-b[i])^2 for i in firstindex(a):1:lastindex(a)]))
end

let tot = 0, points = [lineToPoint(line) for line in readlines("inputs/8.txt")], dist = Dict()
	for a in firstindex(points):1:lastindex(points)
		for b in a+1:1:lastindex(points)
			d = distance(points[a],points[b])
			# testing indicates distances are unique
			dist[d] = (points[a],points[b])
		end
	end
	i = 0
	circuits = []
	for d in sort(collect(keys(dist)))
		if i >= 1000
			break
		end
		a, b = dist[d]
		added = false
		for circuit in circuits
			if a in circuit || b in circuit
				push!(circuit, a)
				push!(circuit, b)
				added = true
			end
		end
		if !added
			push!(circuits, Set([a,b]))
		end
		i += 1
	end
	# reduce
	for x in firstindex(circuits):1:lastindex(circuits)
		for y in x+1:1:lastindex(circuits)
			if !isdisjoint(circuits[x], circuits[y])
				circuits[y] = union(circuits[x], circuits[y])
				circuits[x] = Set()
				break
			end
		end
	end
	lens = [length(i) for i in circuits]
	print("lengths $(sort(lens))\n")
end
