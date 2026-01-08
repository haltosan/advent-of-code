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
