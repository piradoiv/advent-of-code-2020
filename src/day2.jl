### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 648feaae-3410-11eb-2b30-4d3bb934f247
using Test

# ╔═╡ f4d053d4-340f-11eb-0285-b1f852cfc4f5
include("common.jl")

# ╔═╡ 10e2b764-3416-11eb-15d5-83cfd13f60cb
md"# Day 2 - Password Philosophy

Please find the full Advent of Code instructions for this challenge at:"

# ╔═╡ ccbe7928-3416-11eb-14e7-3ffa88e222c8
md"[https://adventofcode.com/2020/day/2](https://adventofcode.com/2020/day/2)"

# ╔═╡ 5fde7a1e-33bd-11eb-0f82-1dc272f1acda
md"## Part One"

# ╔═╡ e7ea5964-33ea-11eb-20e5-9585e0e80e21
md"How many passwords are valid according to their policies?"

# ╔═╡ 97ccfa62-3562-11eb-1cbf-71ff6df88732
struct Policy
	pass::String
	min::Int64
	max::Int64
	char::Char
end

# ╔═╡ 6bb114c0-3569-11eb-0ef6-6d8d45314dd9
validatePassword(p::Policy) = p.min <= count(x->(x == p.char), p.pass) <= p.max

# ╔═╡ 1d6ec30e-3553-11eb-3c2e-c5c06cd478e5
function getPolicy(x)
	parts = split(x, " ")
	minMax = split(parts[1], "-") |> x->map(s->parse(Int, s), x)
	character = replace(parts[2], ":" => "") |> y->collect(y)[1]
	return Policy(parts[3], minMax[1], minMax[2], character)
end

# ╔═╡ 3be1c382-3561-11eb-0ae2-d56b4e57f598
validatePassword(x) = getPolicy(x) |> validatePassword

# ╔═╡ 12ca7c72-33eb-11eb-2170-55fd2f5cbe9b
md"### Tests"

# ╔═╡ 561400b6-33eb-11eb-2100-a5584fa4337b
md"For example, suppose you have the following list:

```
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
```

Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, `1-3` a means that the password must contain a at least `1` time and at most `3` times.

In the above example, `2` passwords are valid. The middle password, `cdefg`, is not; it contains no instances of `b`, but needs at least `1`. The first and third passwords are valid: they contain one `a` or nine `c`, both within the limits of their respective policies."

# ╔═╡ 72d8519c-33ba-11eb-28b4-572c5a7ec6ea
testInput = "1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc" |> x->split(strip(x), "\n")

# ╔═╡ 938a57fa-33ec-11eb-108d-199dbc72d0a0
@test validatePassword("1-3 a: abcde") == true

# ╔═╡ e5045ac8-354c-11eb-2183-35a0e9a1c1e5
@test validatePassword("1-3 b: cdefg") == false

# ╔═╡ ee0763ce-354c-11eb-1801-09a035d87e10
@test validatePassword("2-9 c: ccccccccc") == true

# ╔═╡ b4aed502-3563-11eb-123c-497eeddfd128
@test map(validatePassword, testInput) |> x->filter(y->y == true, x) |> count == 2

# ╔═╡ 6ab8aeae-33eb-11eb-2d78-c9f339174f35
md"### Result

How many passwords are valid according to their policies?"

# ╔═╡ d3c0f4d4-33bd-11eb-3be3-fbb3d237c905
md"## Part Two"

# ╔═╡ 521ca748-3566-11eb-1f96-39620f83a0b0
md"Each policy actually describes two positions in the password, where `1` means the first character, `2` means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of \"index zero\"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement."

# ╔═╡ 80c3d2a8-3569-11eb-0bf2-4579e3604b00
isTobogganPass(p::Policy) = xor(p.pass[p.min] == p.char, p.pass[p.max] == p.char)

# ╔═╡ 069a07f6-3567-11eb-0c9a-6f3be6b7b824
isTobogganPass(input) = getPolicy(input) |> isTobogganPass

# ╔═╡ 0208b444-3567-11eb-1fb8-ed5530cefcbb
md"Given the same example list from above:"

# ╔═╡ 8e6e5836-3566-11eb-141b-dbe0fcc6eac3
md"`1-3 a: abcde` is valid: position `1` contains a and position `3` does not."

# ╔═╡ c20ec284-3566-11eb-3880-7971da2e87a3
@test isTobogganPass("1-3 a: abcde") == true

# ╔═╡ a2b176ca-3566-11eb-3001-d5be21a1b583
md"`1-3 b: cdefg` is invalid: neither position `1` nor position `3` contains `b`."

# ╔═╡ d4eb6f40-3566-11eb-3b5a-0160064df355
@test isTobogganPass("1-3 b: cdefg") == false

# ╔═╡ aeff997a-3566-11eb-056a-bf4a67cd9f24
md"`2-9 c: ccccccccc` is invalid: both position `2` and position `9` contain `c`."

# ╔═╡ dfa098cc-3566-11eb-1c7d-4bb2e77646af
@test isTobogganPass("2-9 c: ccccccccc") == false

# ╔═╡ c94c1762-3567-11eb-1d9f-9b18c758b922
md"How many passwords are valid according to the new interpretation of the policies?"

# ╔═╡ dcf00e68-33eb-11eb-1801-9be72f52ccc1
md"### Result"

# ╔═╡ 202fb894-33bd-11eb-0232-bb0f06888f13
puzzleInput = readFileLines("day2-input.txt")

# ╔═╡ 3d8e224c-33be-11eb-2ca5-c72ce0c7e25d
map(validatePassword, puzzleInput) |> x->filter(y->y == true, x) |> count

# ╔═╡ d0438352-3567-11eb-086a-c512f405e8d9
map(isTobogganPass, puzzleInput) |> x->filter(y->y == true, x) |> count

# ╔═╡ Cell order:
# ╠═f4d053d4-340f-11eb-0285-b1f852cfc4f5
# ╠═648feaae-3410-11eb-2b30-4d3bb934f247
# ╟─10e2b764-3416-11eb-15d5-83cfd13f60cb
# ╟─ccbe7928-3416-11eb-14e7-3ffa88e222c8
# ╟─5fde7a1e-33bd-11eb-0f82-1dc272f1acda
# ╟─e7ea5964-33ea-11eb-20e5-9585e0e80e21
# ╠═97ccfa62-3562-11eb-1cbf-71ff6df88732
# ╠═6bb114c0-3569-11eb-0ef6-6d8d45314dd9
# ╠═3be1c382-3561-11eb-0ae2-d56b4e57f598
# ╠═1d6ec30e-3553-11eb-3c2e-c5c06cd478e5
# ╟─12ca7c72-33eb-11eb-2170-55fd2f5cbe9b
# ╟─561400b6-33eb-11eb-2100-a5584fa4337b
# ╟─72d8519c-33ba-11eb-28b4-572c5a7ec6ea
# ╠═938a57fa-33ec-11eb-108d-199dbc72d0a0
# ╠═e5045ac8-354c-11eb-2183-35a0e9a1c1e5
# ╠═ee0763ce-354c-11eb-1801-09a035d87e10
# ╠═b4aed502-3563-11eb-123c-497eeddfd128
# ╟─6ab8aeae-33eb-11eb-2d78-c9f339174f35
# ╠═3d8e224c-33be-11eb-2ca5-c72ce0c7e25d
# ╟─d3c0f4d4-33bd-11eb-3be3-fbb3d237c905
# ╟─521ca748-3566-11eb-1f96-39620f83a0b0
# ╠═80c3d2a8-3569-11eb-0bf2-4579e3604b00
# ╠═069a07f6-3567-11eb-0c9a-6f3be6b7b824
# ╟─0208b444-3567-11eb-1fb8-ed5530cefcbb
# ╟─8e6e5836-3566-11eb-141b-dbe0fcc6eac3
# ╠═c20ec284-3566-11eb-3880-7971da2e87a3
# ╟─a2b176ca-3566-11eb-3001-d5be21a1b583
# ╠═d4eb6f40-3566-11eb-3b5a-0160064df355
# ╟─aeff997a-3566-11eb-056a-bf4a67cd9f24
# ╠═dfa098cc-3566-11eb-1c7d-4bb2e77646af
# ╟─c94c1762-3567-11eb-1d9f-9b18c758b922
# ╠═d0438352-3567-11eb-086a-c512f405e8d9
# ╠═dcf00e68-33eb-11eb-1801-9be72f52ccc1
# ╠═202fb894-33bd-11eb-0232-bb0f06888f13
