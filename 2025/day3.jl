using Distributed

Distributed.addprocs(["worker@pi3"], dir="/home/worker", exename="/home/worker/.juliaup/bin/julia")

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

@everywhere function getJoltage(line, remaining)
	if remaining < 0
		return ""
	end
	digit = maximum(line[begin:1:end-remaining])
	i = findfirst(x -> x == digit, line)
	return string(digit, getJoltage(line[i+1:1:end], remaining-1))
end

function getJoltageWrapper(chunk, remaining)
	tot = 0
	for line in chunk
		tot += parse(Int, getJoltage(line, remaining))
	end
	return tot
end

function partTwo()
	let tot = 0
		for line in readlines("inputs/3.txt")
			value = getJoltage(line, 11)
			tot += parse(Int, value)
		end
		print("total $(tot)\n")
	end # 175304218462560
end

function partTwoThreaded()
	let lines = readlines("inputs/3.txt")
		chunks = Iterators.partition(lines, cld(length(lines), Threads.nthreads()))
		tasks = map(chunks) do chunk
			Threads.@spawn getJoltageWrapper(chunk, 11)
		end
		chunk_sums = fetch.(tasks)
		print("total $(sum(chunk_sums))\n")
	end
end

function partTwoDistributed()
	let lines = readlines("inputs/3.txt")
		tot = Distributed.@distributed (+) for line in lines
			parse(Int, getJoltage(line, 11))
		end
		print("total $(tot)\n")
	end
end

partTwoDistributed()
