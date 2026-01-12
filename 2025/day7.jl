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
