function partOne()
    let L=140, W=140, count=0, table=Array{Bool}(undef, L, W), y=1, x=1
        function getI(x,y)
            if x < 1 || x > W || y < 1 || y > L
                return false
            end
            return table[y,x]
        end
        function hasRoom(x,y)
            if !getI(x,y)
                return false
            end
            neighbors = map(getI, [x-1, x-1, x-1, x, x, x+1, x+1, x+1], [y-1, y, y+1, y-1, y+1, y-1, y, y+1])
            filled = sum(neighbors)
            return filled < 4
        end

        for line in readlines("2025/inputs/4.txt")
            x=1
            for char in line
                table[y,x] = (char == '@')
                x += 1
            end
            y += 1
        end
        movable = map(hasRoom, repeat(1:W, inner=L), repeat(1:L, outer=W))
        print(sum(movable))
        # 1163 - too low
        # 1569 - correct
    end
end

let L=140, W=140, count=0, table=Array{Bool}(undef, L, W), tablePrime=Array{Bool}(undef, L, W), y=1, x=1
    function getI(x,y)
        if x < 1 || x > W || y < 1 || y > L
            return false
        end
        return table[y,x]
    end
    function hasRoom(x,y)
        if !getI(x,y)
            return false
        end
        neighbors = map(getI, [x-1, x-1, x-1, x, x, x+1, x+1, x+1], [y-1, y, y+1, y-1, y+1, y-1, y, y+1])
        filled = sum(neighbors)
        return filled < 4
    end

    for line in readlines("inputs/4.txt")
        x=1
        for char in line
            table[y,x] = (char == '@')
            x += 1
        end
        y += 1
    end
    tot = 0
    while true
        movable = map(hasRoom, repeat(1:W, inner=L), repeat(1:L, outer=W))
	tot += sum(movable)
	for i = 1:size(movable,1)
		x = 1 + ((i-1)%L)
		y = 1 + div(i-1, W)
		if movable[i] == 1
			tablePrime[x, y] = 0
		else
			tablePrime[x, y] = table[x, y]
		end
	end
	if table == tablePrime
		break
	end
	table = copy(tablePrime)
    end
    print("total: $(tot)\n")
end
