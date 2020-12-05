# Day 4 - Passport Processing

using Match

validPassports(input::String, validator) =
    # "foo:2029 bar:blu\nbaz:129\n\nfoo:2029 bar:blu\nbaz:129"
    split(input, "\n\n") |>
    # ["foo:2029 bar:blu\nbaz:129", "foo:2029 bar:blu\nbaz:129"] (Substrings)
    x -> map(p -> string(p), x) |>
    # ["foo:2029 bar:blu\nbaz:129", "foo:2029 bar:blu\nbaz:129"] (Strings)
    x -> validPassports(x, validator)

validPassports(passports, validator) =
    # ["foo:2029 bar:blu\nbaz:129", "foo:2029 bar:blu\nbaz:129"]
    map(x -> validPassport(x, validator), passports) |>
    # [false, false]
    count

validPassport(input::String, validator) =
    # "foo:2029 bar:blu\nbaz:129\n"
    strip(input) |>
    # "foo:2029 bar:blu\nbaz:129"
    x -> replace(x, "\n" => " ") |>
    # "foo:2029 bar:blu baz:129"
    x -> split(x, " ") |>
    # ["foo:2029", "bar:blu", "baz:129"]
    x -> map(y -> split(y, ":"), x) |>
    # [["foo", "2029"], ["bar", "blu"], ["baz", "129"]]
    x -> validPassport(x, validator)

validPassport(passport, validator) =
    # [["foo", "2029"], ["bar", "blu"], ["baz", "129"]]
    map(x -> validator(x), passport) |>
    # [false, false, false]
    count >= 7

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
