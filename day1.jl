### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 5a0c4dee-33bd-11eb-23e9-1f1c06642ab7
using Markdown

# ╔═╡ b2be34fc-33ba-11eb-326a-d38bb19a454c
using Test

# ╔═╡ 650d3f9c-33e6-11eb-1669-53e0450d7c85
using Combinatorics

# ╔═╡ 5a9d7804-33bb-11eb-020f-6302eafcbcee
puzzleToNumericArray(input) = map(x -> parse(Int64, x), split(input, "\n"))

# ╔═╡ 202fb894-33bd-11eb-0232-bb0f06888f13
puzzleInput = puzzleToNumericArray("1891
1975
1987
1923
1928
1993
1946
1947
2005
1897
1971
1929
1875
1945
1680
811
1901
1396
1942
1282
1941
1978
1884
1879
1230
2010
1881
1979
1996
1904
1934
1865
2003
2006
1966
1860
1259
1959
1931
1963
1878
1880
151
1925
1663
1908
1863
1391
1922
1968
1998
1084
1982
1960
1938
1876
1937
1882
1873
1926
1986
1416
1864
1862
1969
1913
532
1866
1242
1933
1903
965
1927
1890
1991
1388
1992
1902
1907
1964
1394
2009
1920
630
1932
1854
1951
1852
1983
1314
1855
1954
1921
1989
1871
1995
1885
1974
1915
1872
1251
1899
1985
1889
1935
1912
946
1965
1739
1973
1911
1910
1917
1918
1900
1886
1477
2000
1916
1077
2004
1456
1867
1970
1999
1919
1726
706
1930
1994
1988
1997
1870
1953
652
1893
1898
1883
1957
1972
1874
1977
1955
2001
1906
1389
1848
1940
1877
1962
1948
1887
1924
1403
1408
1861
1892
1990
1222
677
1392
1113
1085
1894
1106
1939
1961
1944
1952
1643
1404
1895
1958
1976
1206
1905
1076
1888
1896
1943
1950
2008
1967
164
1981
1868
1914
1909
1956
341
1379
2007
1563
1980
1072
1949
1250
1258
1092
2002")

# ╔═╡ 5fde7a1e-33bd-11eb-0f82-1dc272f1acda
md"## Part One"

# ╔═╡ e7ea5964-33ea-11eb-20e5-9585e0e80e21
md"Find the two entries that sum to 2020 and then multiply those two numbers together."

# ╔═╡ d0af2c46-33ba-11eb-372f-357ab6dc9a29
function findEntriesThatSum(expectedResult, values, combinationsOfNumbers=2)
	for combination in combinations(values, combinationsOfNumbers)
		sum(combination) == expectedResult && return combination
	end
end

# ╔═╡ 12ca7c72-33eb-11eb-2170-55fd2f5cbe9b
md"### Tests"

# ╔═╡ 561400b6-33eb-11eb-2100-a5584fa4337b
md"In this list, the two entries that sum to `2020` are `1721` and `299`. Multiplying them together produces `1721 * 299 = 514579`, so the correct answer is `514579`."

# ╔═╡ 72d8519c-33ba-11eb-28b4-572c5a7ec6ea
testInput = puzzleToNumericArray("1721
979
366
299
675
1456")

# ╔═╡ a477d988-33bb-11eb-2b4d-570b1d51f27c
@test findEntriesThatSum(2020, testInput) == [1721, 299]

# ╔═╡ 938a57fa-33ec-11eb-108d-199dbc72d0a0
@test reduce(*, findEntriesThatSum(2020, testInput)) == 514579

# ╔═╡ 6ab8aeae-33eb-11eb-2d78-c9f339174f35
md"### Result"

# ╔═╡ 2d9467c6-33bd-11eb-255c-15cca08b8489
reduce(*, findEntriesThatSum(2020, puzzleInput))

# ╔═╡ d3c0f4d4-33bd-11eb-3be3-fbb3d237c905
md"## Part Two"

# ╔═╡ 9c905eb8-33eb-11eb-0f36-016fe88a648e
md"Find three numbers in your expense report that meet the same criteria."

# ╔═╡ a78a48a6-33eb-11eb-0f5e-a3a376574fb2
md"### Tests"

# ╔═╡ ac954c4a-33eb-11eb-00bb-69919ae91aa8
md"Using the above example again, the three entries that sum to `2020` are `979`, `366`, and `675`. Multiplying them together produces the answer, `241861950`."

# ╔═╡ 6704474c-33e7-11eb-35f0-33783ab18364
@test findEntriesThatSum(2020, testInput, 3) == [979, 366, 675]

# ╔═╡ c260efae-33eb-11eb-22b5-590a6c3c0df8
@test reduce(*, findEntriesThatSum(2020, testInput, 3)) == 241861950

# ╔═╡ dcf00e68-33eb-11eb-1801-9be72f52ccc1
md"### Result"

# ╔═╡ 3d8e224c-33be-11eb-2ca5-c72ce0c7e25d
reduce(*, findEntriesThatSum(2020, puzzleInput, 3))

# ╔═╡ Cell order:
# ╠═5a0c4dee-33bd-11eb-23e9-1f1c06642ab7
# ╠═b2be34fc-33ba-11eb-326a-d38bb19a454c
# ╠═650d3f9c-33e6-11eb-1669-53e0450d7c85
# ╠═5a9d7804-33bb-11eb-020f-6302eafcbcee
# ╟─202fb894-33bd-11eb-0232-bb0f06888f13
# ╟─5fde7a1e-33bd-11eb-0f82-1dc272f1acda
# ╟─e7ea5964-33ea-11eb-20e5-9585e0e80e21
# ╠═d0af2c46-33ba-11eb-372f-357ab6dc9a29
# ╟─12ca7c72-33eb-11eb-2170-55fd2f5cbe9b
# ╟─561400b6-33eb-11eb-2100-a5584fa4337b
# ╟─72d8519c-33ba-11eb-28b4-572c5a7ec6ea
# ╠═a477d988-33bb-11eb-2b4d-570b1d51f27c
# ╠═938a57fa-33ec-11eb-108d-199dbc72d0a0
# ╟─6ab8aeae-33eb-11eb-2d78-c9f339174f35
# ╠═2d9467c6-33bd-11eb-255c-15cca08b8489
# ╟─d3c0f4d4-33bd-11eb-3be3-fbb3d237c905
# ╟─9c905eb8-33eb-11eb-0f36-016fe88a648e
# ╟─a78a48a6-33eb-11eb-0f5e-a3a376574fb2
# ╟─ac954c4a-33eb-11eb-00bb-69919ae91aa8
# ╠═6704474c-33e7-11eb-35f0-33783ab18364
# ╠═c260efae-33eb-11eb-22b5-590a6c3c0df8
# ╟─dcf00e68-33eb-11eb-1801-9be72f52ccc1
# ╠═3d8e224c-33be-11eb-2ca5-c72ce0c7e25d
