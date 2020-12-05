using Test
using Match

struct BoardingPass
    row::Int64
    column::Int64
    id::Int64
end

function decodeBoardingPass(input::String, rows=1:128, cols=1:8)::BoardingPass
    for ch in input
        if ch in ['F', 'B']
            rows = seekSeat(ch, rows)
        else
            cols = seekSeat(ch, cols)
        end
    end

    row = first(rows)
    col = first(cols)
    seat = getBoardingPassId(row, col)

    BoardingPass(row, col, seat)
end

seekSeat(ch, items) = @match ch begin
    'F' || 'L' => items[1:Int64(ceil(length(items) / 2))]
    'B' || 'R' => items[Int64(ceil(length(items) / 2)):length(items)]
    _ => items
end

getBoardingPassId(row, col) = row * 8 + col

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
    boardingPasses -> filter(x -> 10 < x.row < 110, boardingPasses) |>
    first

println(partTwo(puzzleInput))
@test partTwo(puzzleInput).id == 743
