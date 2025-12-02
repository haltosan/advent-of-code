function is_bad_1(n)
    return !isnothing(match(r"^(.+)\1$", string(n)))
end

function part_one()
    let tot=0
        raw = read("2025/inputs/2.txt", String)
        ranges = split(raw, ",")
        for range in ranges
            range_start, range_end = split(range, "-")
            for number = parse(Int64, range_start):parse(Int64, range_end)
                if is_bad_1(number)
                    tot += number
                end
            end
        end
        println(tot)
    end
end

function is_bad_2(n)
    return !isnothing(match(r"^(.+)\1+$", string(n)))
end

let tot=0
    let tot=0
        raw = read("2025/inputs/2.txt", String)
        ranges = split(raw, ",")
        for range in ranges
            range_start, range_end = split(range, "-")
            for number = parse(Int64, range_start):parse(Int64, range_end)
                if is_bad_2(number)
                    tot += number
                end
            end
        end
        println(tot)
    end
end