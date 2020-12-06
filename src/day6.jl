puzzleInput =
    open(f -> read(f, String), "input/day6.txt") |>
    strip |>
    x -> split(x, "\n\n") |>
    x -> String.(x)

partOne(input) =
    replace.(input, '\n' => "") |>
    x -> split.(x, "") |>
    x -> unique.(x) |>
    x -> length.(x) |>
    sum

println("Part One: ", partOne(puzzleInput))

partTwo(input) =
    split.(input, "\n") |>
    x -> map(y -> intersect(y...), x) |>
    x -> length.(x) |>
    sum

println("Part Two: ", partTwo(puzzleInput))
