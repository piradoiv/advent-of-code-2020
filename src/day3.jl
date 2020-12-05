include("common.jl")

struct Position
    x::Int64
    y::Int64
end

getCellAt(grid, pos) = grid[pos.y+1][(pos.x%length(grid[1]))+1]

treesEncountered(grid, slope) =
    walk(grid, slope) |> x -> findall(c -> c == '#', x) |> length

function walk(grid, slope)
    result = ""
    pos = [0, 0]
    max_pos = length(grid) - 1
    while pos[2] + 1 <= max_pos
        pos += slope
        result = string(result, getCellAt(grid, Position(pos[1], pos[2])))
    end
    return result
end

puzzleInput = readFileLines("input/day3.txt")

# Part 1
println("Part 1: ", treesEncountered(puzzleInput, [3, 1]))

# Part 2
print("Part 2: ")
[[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]] |>
slopes -> map(slope -> treesEncountered(puzzleInput, slope), slopes) |> prod |> println
