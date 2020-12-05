using Test
using Match
using Combinatorics

struct BoardingPass
    row::Int64
    column::Int64
    id::Int64
end

getBoardingPassId(row, col) = row * 8 + col

function decodeBoardingPass(input::String, r=1:128, c=1:8)::BoardingPass
    for ch in input
        r = @match ch begin
            'F' => r[1:Int64(ceil(length(r) / 2))]
            'B' => r[Int64(ceil(length(r) / 2)):length(r)]
            _ => r
        end

        c = @match ch begin
            'L' => c[1:Int64(ceil(length(c) / 2))]
            'R' => c[Int64(ceil(length(c) / 2)):length(c)]
            _ => c
        end
    end

    row = first(r)
    col = first(c)
    seat = getBoardingPassId(row, col)

    BoardingPass(row, col, seat)
end

@test decodeBoardingPass("BFFFBBFRRR") == BoardingPass(70, 7, 567)
@test decodeBoardingPass("FFFBBBFRRR") == BoardingPass(14, 7, 119)
@test decodeBoardingPass("BBFFBBFRLL") == BoardingPass(102, 4, 820)

# Part One: What is the highest seat ID on a boarding pass?
puzzleInput =
    open(f -> read(f, String), "input/day5.txt") |>
    x -> split(x, "\n") |>
    x -> map(String, x)

partOne(input)::Int64 =
    map(decodeBoardingPass, input) |>
    boardingPasses -> map(x -> x.id, boardingPasses) |>
    maximum

println(partOne(puzzleInput))
@test partOne(puzzleInput) == 935

# Part Two: What is the ID of your seat?
function buildSeats(rows, cols)
    result = []
    for row in rows
        for col in cols
            push!(result, BoardingPass(row, col, getBoardingPassId(row, col)))
        end
    end
    return result
end

partTwo(input)::BoardingPass =
    map(decodeBoardingPass, input) |>
    boardingPasses -> filter(x -> x ∉ boardingPasses, buildSeats(1:120, 1:7)) |>
    pass -> filter(x -> 10 < x.row < 110, pass) |>
    first

println(partTwo(puzzleInput))
@test partTwo(puzzleInput).id == 743
