function parseLine(x)
	[parse(Int, i) for i in split(x, ",")]
end
function area(a,b)
	(1+abs(a[begin]-b[begin])) * (1+abs(a[end]-b[end]))
end

let mx = -1, points = [parseLine(i) for i in readlines("inputs/9.txt")]
	for xi in firstindex(points):1:lastindex(points)
		x = points[xi]
		for yi in xi+1:1:lastindex(points)
			y = points[yi]
			a = area(x,y)
			if a > mx
				mx = a
			end
		end
	end
	print("max $(mx)\n")
end
