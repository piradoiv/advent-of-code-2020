puzzleInput =
    open(f -> read(f, String), "input/day6.txt") |>
    strip |>
    x -> split(x, "\n\n") |>
    x -> String.(x)

sumLengths(arr) = length.(arr) |> sum

partOne(input) =
    replace.(input, "\n" => "") |> x -> split.(x, "") |> x -> unique.(x) |> sumLengths

partTwo(input) =
    split.(input, "\n") |> x -> map(y -> intersect(y...), x) |> sumLengths

println("Part One: ", partOne(puzzleInput))
println("Part Two: ", partTwo(puzzleInput))
