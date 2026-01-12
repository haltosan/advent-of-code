function partOne()
	let tot = 0, isFirst = true, cols = [], colI = firstindex(cols)
		for line in readlines("inputs/6.txt")
			numbers = [i for i in split(line, " ") if i != ""]
			for number in numbers
				if isFirst
					push!(cols, [])
				end
				push!(cols[colI], number)
				colI += 1
			end
			isFirst = false
			colI = firstindex(cols)
		end
		for col in cols
			if col[end] == "+"
				tot += sum(parse.(Int, col[begin:1:end-1]))
			else
				tot += reduce((*), parse.(Int, col[begin:1:end-1]))
			end
		end
		print("total $(tot)\n")
	end
end

let tot = 0, lines = readlines("inputs/6.txt"), ncols = length(lines[begin]), cols = ["" for _ in 1:ncols]
	for i in 1:1:ncols
		for line in lines
			cols[i] = cols[i] * line[i]
		end
	end
	print("cols $(cols)\n")
	buf = 0
	op = (+)
	for num in cols
		if lstrip(num) == ""
			print(" = $(buf)\n")
			tot += buf
			buf = 0
			continue
		end
		if '+' in num
			buf = 0
			print("+ ")
			op = (+)
			num = num[begin:end-1]
		end
		if '*' in num
			buf = 1
			print("* ")
			op = (*)
			num = num[begin:end-1]
		end
		num = parse(Int, num)
		print("$(num)\t")
		buf = op(buf, num)
	end
	tot += buf
	print("\ntotal $(tot)\n")
end
