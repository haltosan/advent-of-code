function tryOne()
	let fresh = Set{Int}(), tot = 0, sumTime = false
		for line in readlines("inputs/5.txt")
			if line == ""
				sumTime = true
				continue
			end
			if sumTime
				if parse(Int, line) in fresh
					tot += 1
				end
			else
				chunks = map(x -> parse(Int, x), split(line, "-"))
				union!(fresh, chunks[begin]:1:chunks[end])
			end
		end
		print("total $(tot)\n")
	end
end  # out of memory

function partOne()
	let ranges = Set{StepRange{Int}}(), tot = 0, sumTime = false
		for line in readlines("inputs/5.txt")
			if line == ""
				sumTime = true
				continue
			end
			if sumTime
				let intLine = parse(Int, line)
					for i in ranges
						if intLine in i
							tot += 1
							break
						end
					end
				end
			else
				chunks = map(x -> parse(Int, x), split(line, "-"))
				push!(ranges, chunks[begin]:1:chunks[end])
			end
		end
		print("total $(tot)\n")
	end
end

let ranges = [], tot = 0
	for line in readlines("inputs/5.txt")
		if line == ""
			break
		end
		chunks = map(x -> parse(Int, x), split(line, "-"))
		push!(ranges, chunks[begin]:1:chunks[end])
	end
	# reduce ranges
	for i in eachindex(ranges)
		for l in i+1:1:lastindex(ranges)
			a = ranges[i]
			b = ranges[l]
			if a.stop < b.start || b.stop < a.start
				# ranges don't interact
				continue
			end
			ranges[l] = min(a.start, b.start):1:max(a.stop, b.stop)
			ranges[i] = 1:0
			break  # range doesn't exist anymore
		end
	end
	for range in ranges
		tot += length(range)
	end
	print("total $(tot)\n")
end
