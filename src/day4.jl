# Day 4 - Passport Processing

using Match

validPassports(input::String, validator) =
    split(input, "\n\n") |>
    x -> map(p -> string(p), x) |>
    x -> validPassports(x, validator)

validPassports(passports, validator) =
    map(x -> validPassport(x, validator), passports) |>
    count

validPassport(input::String, validator) =
    strip(input) |>
    x -> replace(x, "\n" => " ") |>
    x -> split(x, " ") |>
    x -> map(y -> split(y, ":"), x) |>
    x -> validPassport(x, validator)

validPassport(passport, validator) = map(x -> validator(x), passport) |> count >= 7

puzzleInput = open(f -> read(f, String), "input/day4.txt")

# Part One
partOneValidator(field) = field[1] in ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
validPassports(puzzleInput, partOneValidator)

# Part Two
partTwoValidator(field) =
    @match field[1] begin
        "byr" => 1920 <= parse(Int64, field[2]) <= 2002
        "iyr" => 2010 <= parse(Int64, field[2]) <= 2020
        "eyr" => 2020 <= parse(Int64, field[2]) <= 2030
        "hgt", if occursin("cm", field[2]) end => replace(field[2], "cm" => "") |> x -> parse(Int64, x) |> x -> 150 <= x <= 193
        "hgt", if occursin("in", field[2]) end => replace(field[2], "in" => "") |> x -> parse(Int64, x) |> x -> 59 <= x <= 76
        "hcl" => match(r"^#[0-9|a-f|A-F]{6,6}$", field[2]) != nothing
        "ecl" => match(r"^(amb|blu|brn|gry|grn|hzl|oth)$", field[2]) != nothing
        "pid" => match(r"^[0-9]{9,9}$", field[2]) != nothing
        _ => false
    end
validPassports(puzzleInput, partTwoValidator)
