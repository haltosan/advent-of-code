function parseLine(x)
	[parse(Int, i) for i in split(x, ",")]
end
function area(a,b)
	(1+abs(a[begin]-b[begin])) * (1+abs(a[end]-b[end]))
end

function partOne()
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
end

struct Point
	x::Int
	y::Int
end
struct Line
	x::Union{Int,UnitRange{Int}}
	y::Union{Int,UnitRange{Int}}
	axis::Char
end

function parseLine2(x)
	p = parseLine(x)
	return Point(p[begin], p[end])
end

function findLine(a,b)
	if a.x == b.x
		if a.y < b.y
			Line(a.x,a.y:b.y,'x')
		else
			Line(a.x,b.y:a.y,'x')
		end
	else
		if a.x < b.x
			Line(a.x:b.x,a.y,'y')
		else
			Line(b.x:a.x,a.y,'y')
		end
	end
end

function onLine(p::Point, l::Line)
	if l.axis == 'x'
		return (p.x == l.x) && (p.y in l.y)
	else
		return (p.y == l.y) && (p.x in l.x)
	end
end

function area(a::Point, b::Point)
	(1+abs(a.x-b.x)) * (1+abs(a.y-b.y))
end

let mx = -1, points = [parseLine2(i) for i in readlines("inputs/9.txt")], lines = []
	for xi in firstindex(points):1:lastindex(points)-1
		x = points[xi]
		y = points[xi+1]
		push!(lines, findLine(x,y))
	end
	push!(lines, findLine(points[begin], points[end]))
	for xi in firstindex(points):1:lastindex(points)-1
		x = points[xi]
		for yi in xi+1:1:lastindex(points)
			y = points[yi]
			corners = [Point(x.x, y.y), Point(y.x, x.y)]
			if all(p -> any(line -> onLine(p, line), lines), corners)
				a = area(x,y)
				if a > mx
					mx = a
				end
			end
		end
	end
	print("max $(mx)\n")
end  # 199444724 - wrong
