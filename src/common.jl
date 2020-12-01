puzzleToNumericArray(input) = map(x -> parse(Int64, x), split(input, "\n"))
