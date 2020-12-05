### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 75a3a4b0-3590-11eb-0bf6-775e16dbd22d
using Test

# ╔═╡ b36e8302-35a4-11eb-13a5-9bb90c64453e
include("../common.jl")

# ╔═╡ c6bc401e-359c-11eb-1f6e-ad285140b5ff
md"# Day 3 - Toboggan Trajectory
Please find the full Advent of Code instructions for this challenge at:    
[https://adventofcode.com/2020/day/3](https://adventofcode.com/2020/day/3)"

# ╔═╡ 4f8abf1e-35a3-11eb-1533-55cd039d93f6
struct Position
	x::Int64
	y::Int64
end

# ╔═╡ 978f03b0-358f-11eb-3125-2bd1fa5c4e05
getCellAt(grid, pos) = grid[pos.y + 1][(pos.x % length(grid[1])) + 1]

# ╔═╡ ad3c332a-3596-11eb-1514-512617feb224
function walk(grid, velocity)
	result = ""
	xy = [0, 0]
	while xy[2] + 1 <= length(grid) - 1
		xy += velocity
		result = string(result, getCellAt(grid, Position(xy[1], xy[2])))
	end
	return result
end

# ╔═╡ 8bf60c5a-359f-11eb-2b4a-836d14382c7d
treesEncountered(grid, velocity) = walk(grid, velocity) |>
								   x->findall(c->c == '#', x) |>
								   length

# ╔═╡ 276dd4ae-359d-11eb-1034-af569084528d
md"## Tests"

# ╔═╡ 67d7fdca-358f-11eb-20a7-fb80acece997
testInput = split("..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#", "\n")

# ╔═╡ 7838e2f0-3590-11eb-0944-8fb86cce8ee7
@test getCellAt(testInput, Position(3, 1)) == '.'

# ╔═╡ 4a7ed528-3596-11eb-398b-41097e320b14
@test getCellAt(testInput, Position(24, 8)) == '#'

# ╔═╡ 4d759288-3596-11eb-1fbd-67e9a57fd008
@test getCellAt(testInput, Position(27, 9)) == '#'

# ╔═╡ 50b98fee-3596-11eb-112e-9900696ce9b9
@test getCellAt(testInput, Position(30, 10)) == '#'

# ╔═╡ 11bad92c-359d-11eb-11de-5509008873e5
md"## Part One

Starting at the top-left corner of your map and following a slope of right 3 and down 1, how many trees would you encounter?"

# ╔═╡ 19d479ba-359d-11eb-37f0-65c9ef2c6137
md"## Part Two

What do you get if you multiply together the number of trees encountered on each of the listed slopes?

- Right 1, down 1.
- Right 3, down 1. (This is the slope you already checked.)
- Right 5, down 1.
- Right 7, down 1.
- Right 1, down 2."

# ╔═╡ 6e98900e-3597-11eb-3a8c-83f741c63ad1
puzzleInput = readFileLines("../input/day3.txt")

# ╔═╡ abd3616c-359f-11eb-00ed-130f3e2eb233
treesEncountered(puzzleInput, [3, 1])

# ╔═╡ b2446314-3597-11eb-05ff-cbad1dc889ff
[[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]] |>
slopes->map(velocity->treesEncountered(puzzleInput, velocity), slopes) |> prod

# ╔═╡ Cell order:
# ╠═b36e8302-35a4-11eb-13a5-9bb90c64453e
# ╠═75a3a4b0-3590-11eb-0bf6-775e16dbd22d
# ╟─c6bc401e-359c-11eb-1f6e-ad285140b5ff
# ╠═4f8abf1e-35a3-11eb-1533-55cd039d93f6
# ╠═978f03b0-358f-11eb-3125-2bd1fa5c4e05
# ╠═ad3c332a-3596-11eb-1514-512617feb224
# ╠═8bf60c5a-359f-11eb-2b4a-836d14382c7d
# ╟─276dd4ae-359d-11eb-1034-af569084528d
# ╟─67d7fdca-358f-11eb-20a7-fb80acece997
# ╠═7838e2f0-3590-11eb-0944-8fb86cce8ee7
# ╠═4a7ed528-3596-11eb-398b-41097e320b14
# ╠═4d759288-3596-11eb-1fbd-67e9a57fd008
# ╠═50b98fee-3596-11eb-112e-9900696ce9b9
# ╟─11bad92c-359d-11eb-11de-5509008873e5
# ╠═abd3616c-359f-11eb-00ed-130f3e2eb233
# ╟─19d479ba-359d-11eb-37f0-65c9ef2c6137
# ╠═b2446314-3597-11eb-05ff-cbad1dc889ff
# ╟─6e98900e-3597-11eb-3a8c-83f741c63ad1
