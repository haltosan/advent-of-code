function partOne()
	let tot = 0, first = -1, firstI = -1, second = -1, secondI = -1
		for line in readlines("inputs/3.txt")
			first = maximum(line[begin:1:end-1])
			firstI = findfirst(x -> x == first, line)
			second = maximum(line[firstI+1:1:end])
			secondI = findfirst(x -> x == second, line[firstI+1:1:end])
			value = parse(Int, first) * 10 + parse(Int, second)
			tot += value
		end
		print("$(tot)\n")
	end
end

function getJoltage(line, remaining)
	if remaining < 0
		return ""
	end
	digit = maximum(line[begin:1:end-remaining])
	i = findfirst(x -> x == digit, line)
	return string(digit, getJoltage(line[i+1:1:end], remaining-1))
end

let tot = 0
	for line in readlines("inputs/3.txt")
		value = getJoltage(line, 11)
		tot += parse(Int, value)
	end
	print("total $(tot)\n")
end
