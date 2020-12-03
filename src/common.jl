puzzleToNumericArray(input) = map(x -> parse(Int64, x), split(strip(input), "\n"))
readFileLines(filename) = open(f -> read(f, String), filename) |> x->split(strip(x), "\n")

