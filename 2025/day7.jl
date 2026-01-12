function partOne()
	let tot = 0, lines = readlines("inputs/7.txt"), prev = split("."^length(lines[begin]), "")
		for line in lines
			cur = []
			onSplit = false
			for i in firstindex(line):1:lastindex(line)
				print("$(prev[i]) ")
				if prev[i] == '|' || prev[i] == 'S'
					if line[i] == '^'
						cur[end] = '|'
						push!(cur, '^')
						onSplit = true
						tot += 1
					else
						push!(cur, '|')
						onSplit = false
					end
				else
					if onSplit
						push!(cur, '|')
						onSplit = false
					else
						push!(cur, line[i])
					end
				end
			end
			prev = copy(cur)
			print("\n")
		end
		print("total $(tot)\n")
	end
end

# depth first search
let tot = 0, lines = readlines("inputs/7.txt"), cache = Dict()
	startI = findnext('S', lines[begin], firstindex(lines[begin]))
	startLine = firstindex(lines) + 1
	print("bounds $(lastindex(lines[begin])) $(lastindex(lines))\n")
	function dfs(i, lineI)
		if (i, lineI) in keys(cache)
			return cache[i, lineI]
		end
		if lineI > lastindex(lines)
			return 1
		end
		if i > lastindex(lines[lineI])
			return 0
		end
		if lines[lineI][i] == '.'
			ans = dfs(i, lineI+1)
			cache[i, lineI] = ans
			return ans
		else
			ans = dfs(i-1, lineI+1) + dfs(i+1, lineI+1)
			cache[i, lineI] = ans
			return ans
		end
	end
	tot = dfs(startI, startLine)
	print("total $(tot)\n")
end
