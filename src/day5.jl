using Test
using Match
using Combinatorics

struct BoardingPass
    row::Int64
    column::Int64
    id::Int64
end

function decodeBoardingPass(input::String, rows=1:128, columns=1:8)::BoardingPass
    r = rows
    c = columns

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

    row = r[1]
    col = c[1]
    seat = row * 8 + col

    BoardingPass(row, col, seat)
end

@test decodeBoardingPass("BFFFBBFRRR") == BoardingPass(70, 7, 567)
@test decodeBoardingPass("FFFBBBFRRR") == BoardingPass(14, 7, 119)
@test decodeBoardingPass("BBFFBBFRLL") == BoardingPass(102, 4, 820)

# Part One
puzzleInput =
    open(f -> read(f, String), "input/day5.txt") |>
    x -> split(x, "\n") |>
    x -> map(String, x)

result = map(decodeBoardingPass, puzzleInput)

println(map(x -> x.id, result) |> maximum)

# Part Two
function generateSeats(rows, cols)
    result = []
    for row in rows
        for col in cols
            push!(result, BoardingPass(row, col, row * 8 + col))
        end
    end
    return result
end

availableSeats = generateSeats(1:118, 1:7)
myBoardingPass = filter(x -> x ∉ result, availableSeats) |> pass -> filter(x -> 10 < x.row < 110, pass)[1]
println(myBoardingPass.id)
