### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 75a3a4b0-3590-11eb-0bf6-775e16dbd22d
using Test

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

# ╔═╡ 978f03b0-358f-11eb-3125-2bd1fa5c4e05
getCellAt(grid, x, y) = grid[y + 1][1 + (x % length(grid[1]))]

# ╔═╡ ad3c332a-3596-11eb-1514-512617feb224
function getWalkTrees(grid, stepsX, stepsY)
	x = 0
	y = 0
	chars = ""
	maxY = length(grid) - 1
	while y <= maxY - 1
		x += stepsX
		y += stepsY
		chars = string(chars, getCellAt(grid, x, y))
	end
	return chars
end

# ╔═╡ 99e62d1a-359b-11eb-04cc-8ba3d5016eb6
[3, 1] |> s->getWalkTrees(testInput, s[1], s[2])

# ╔═╡ 7838e2f0-3590-11eb-0944-8fb86cce8ee7
@test getCellAt(testInput, 3, 1) == '.'

# ╔═╡ 4a7ed528-3596-11eb-398b-41097e320b14
@test getCellAt(testInput, 24, 8) == '#'

# ╔═╡ 4d759288-3596-11eb-1fbd-67e9a57fd008
@test getCellAt(testInput, 27, 9) == '#'

# ╔═╡ 50b98fee-3596-11eb-112e-9900696ce9b9
@test getCellAt(testInput, 30, 10) == '#'

# ╔═╡ 6e98900e-3597-11eb-3a8c-83f741c63ad1
puzzleInput = open(f -> read(f, String), "day3-input.txt") |> x->split(strip(x), "\n")

# ╔═╡ 78645d4a-3597-11eb-04d2-37aeb401d9e7
getWalkTrees(puzzleInput, 3, 1) |> x->findall(c->c == '#', x) |> length

# ╔═╡ b2446314-3597-11eb-05ff-cbad1dc889ff
begin
	[[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]] |>
	slopes->map(s->getWalkTrees(puzzleInput, s[1], s[2]), slopes) |>
	walks->map(x->findall(c->c == '#', x) |> length, walks) |>
	trees->prod(trees)
end

# ╔═╡ Cell order:
# ╠═75a3a4b0-3590-11eb-0bf6-775e16dbd22d
# ╟─67d7fdca-358f-11eb-20a7-fb80acece997
# ╠═978f03b0-358f-11eb-3125-2bd1fa5c4e05
# ╠═ad3c332a-3596-11eb-1514-512617feb224
# ╠═99e62d1a-359b-11eb-04cc-8ba3d5016eb6
# ╠═7838e2f0-3590-11eb-0944-8fb86cce8ee7
# ╠═4a7ed528-3596-11eb-398b-41097e320b14
# ╠═4d759288-3596-11eb-1fbd-67e9a57fd008
# ╠═50b98fee-3596-11eb-112e-9900696ce9b9
# ╠═78645d4a-3597-11eb-04d2-37aeb401d9e7
# ╠═b2446314-3597-11eb-05ff-cbad1dc889ff
# ╟─6e98900e-3597-11eb-3a8c-83f741c63ad1
