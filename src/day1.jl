### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 648feaae-3410-11eb-2b30-4d3bb934f247
using Test

# ╔═╡ 650d3f9c-33e6-11eb-1669-53e0450d7c85
using Combinatorics

# ╔═╡ f4d053d4-340f-11eb-0285-b1f852cfc4f5
include("common.jl")

# ╔═╡ 10e2b764-3416-11eb-15d5-83cfd13f60cb
md"# Day 1 - Report Repair

Please find the full Advent of Code instructions for this challenge at:"

# ╔═╡ ccbe7928-3416-11eb-14e7-3ffa88e222c8
md"[https://adventofcode.com/2020/day/1](https://adventofcode.com/2020/day/1)"

# ╔═╡ 5fde7a1e-33bd-11eb-0f82-1dc272f1acda
md"## Part One"

# ╔═╡ e7ea5964-33ea-11eb-20e5-9585e0e80e21
md"Find the two entries that sum to 2020 and then multiply those two numbers together."

# ╔═╡ d0af2c46-33ba-11eb-372f-357ab6dc9a29
function findEntriesThatSum(expectedResult, values, combinationsOfNumbers=2)
	for combination in combinations(values, combinationsOfNumbers)
		sum(combination) == expectedResult && return combination
	end
end

# ╔═╡ 12ca7c72-33eb-11eb-2170-55fd2f5cbe9b
md"### Tests"

# ╔═╡ 561400b6-33eb-11eb-2100-a5584fa4337b
md"In this list, the two entries that sum to `2020` are `1721` and `299`. Multiplying them together produces `1721 * 299 = 514579`, so the correct answer is `514579`."

# ╔═╡ 72d8519c-33ba-11eb-28b4-572c5a7ec6ea
testInput = puzzleToNumericArray("1721
979
366
299
675
1456")

# ╔═╡ a477d988-33bb-11eb-2b4d-570b1d51f27c
@test findEntriesThatSum(2020, testInput) == [1721, 299]

# ╔═╡ 938a57fa-33ec-11eb-108d-199dbc72d0a0
@test prod(findEntriesThatSum(2020, testInput)) == 514579

# ╔═╡ 6ab8aeae-33eb-11eb-2d78-c9f339174f35
md"### Result"

# ╔═╡ d3c0f4d4-33bd-11eb-3be3-fbb3d237c905
md"## Part Two"

# ╔═╡ 9c905eb8-33eb-11eb-0f36-016fe88a648e
md"Find three numbers in your expense report that meet the same criteria."

# ╔═╡ a78a48a6-33eb-11eb-0f5e-a3a376574fb2
md"### Tests"

# ╔═╡ ac954c4a-33eb-11eb-00bb-69919ae91aa8
md"Using the above example again, the three entries that sum to `2020` are `979`, `366`, and `675`. Multiplying them together produces the answer, `241861950`."

# ╔═╡ 6704474c-33e7-11eb-35f0-33783ab18364
@test findEntriesThatSum(2020, testInput, 3) == [979, 366, 675]

# ╔═╡ c260efae-33eb-11eb-22b5-590a6c3c0df8
@test prod(findEntriesThatSum(2020, testInput, 3)) == 241861950

# ╔═╡ dcf00e68-33eb-11eb-1801-9be72f52ccc1
md"### Result"

# ╔═╡ 202fb894-33bd-11eb-0232-bb0f06888f13
puzzleInput = open(f -> read(f, String), "day1-input.txt") |> puzzleToNumericArray

# ╔═╡ 2d9467c6-33bd-11eb-255c-15cca08b8489
findEntriesThatSum(2020, puzzleInput) |> prod

# ╔═╡ 3d8e224c-33be-11eb-2ca5-c72ce0c7e25d
findEntriesThatSum(2020, puzzleInput, 3) |> prod

# ╔═╡ Cell order:
# ╠═f4d053d4-340f-11eb-0285-b1f852cfc4f5
# ╠═648feaae-3410-11eb-2b30-4d3bb934f247
# ╠═650d3f9c-33e6-11eb-1669-53e0450d7c85
# ╟─10e2b764-3416-11eb-15d5-83cfd13f60cb
# ╟─ccbe7928-3416-11eb-14e7-3ffa88e222c8
# ╟─5fde7a1e-33bd-11eb-0f82-1dc272f1acda
# ╟─e7ea5964-33ea-11eb-20e5-9585e0e80e21
# ╠═d0af2c46-33ba-11eb-372f-357ab6dc9a29
# ╟─12ca7c72-33eb-11eb-2170-55fd2f5cbe9b
# ╟─561400b6-33eb-11eb-2100-a5584fa4337b
# ╟─72d8519c-33ba-11eb-28b4-572c5a7ec6ea
# ╠═a477d988-33bb-11eb-2b4d-570b1d51f27c
# ╠═938a57fa-33ec-11eb-108d-199dbc72d0a0
# ╟─6ab8aeae-33eb-11eb-2d78-c9f339174f35
# ╠═2d9467c6-33bd-11eb-255c-15cca08b8489
# ╠═d3c0f4d4-33bd-11eb-3be3-fbb3d237c905
# ╟─9c905eb8-33eb-11eb-0f36-016fe88a648e
# ╟─a78a48a6-33eb-11eb-0f5e-a3a376574fb2
# ╟─ac954c4a-33eb-11eb-00bb-69919ae91aa8
# ╠═6704474c-33e7-11eb-35f0-33783ab18364
# ╠═c260efae-33eb-11eb-22b5-590a6c3c0df8
# ╟─dcf00e68-33eb-11eb-1801-9be72f52ccc1
# ╠═3d8e224c-33be-11eb-2ca5-c72ce0c7e25d
# ╟─202fb894-33bd-11eb-0232-bb0f06888f13
