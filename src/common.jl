puzzleToNumericArray(input) = map(x -> parse(Int64, x), split(strip(input), "\n"))
