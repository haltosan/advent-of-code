
function partOne()
    let Pos=50, Max=100, Acc=0
        for line in readlines("2025/inputs/1.txt")
            if first(line) == 'L'
                Sign = 1
            else
                Sign = -1
            end
            Offset = parse(Int64, line[begin+1:end])
            Pos = (Offset * Sign + Pos) % Max
            if Pos == 0
                Acc += 1
            end
        end
        println("Answer :$(Acc)")
    end
end


let pos=50, max=100, acc=0
    for line in readlines("2025/inputs/1.txt")
        if first(line) == 'L'
            sign = -1
            if pos == 0
                acc -= 1
            end  # double counting
        else
            sign = 1
        end
        offset = parse(Int64, line[begin+1:end])
        pos = offset * sign + pos
        println("$(pos) $((max+pos)%max)")
        while pos > max
            println("too high")
            acc += 1
            pos -= max
        end
        while pos < 0
            println("too low")
            acc += 1
            pos += max
        end
        if pos == max
            pos = 0
        end
        if pos == 0
            println("exact")
            acc += 1
        end
    end
    println("Answer pt 2: $(acc)")
end