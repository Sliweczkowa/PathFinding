#!/usr/bin/env julia

include("pathFinding.jl")
using .pathFinding

print("Precise path to the file with map: ")
open(readline()) do fileWithMap

    # Reading data from .map file

    readline(fileWithMap)
    height = parse(Int32, readline(fileWithMap)[8:end])
    width = parse(Int32, readline(fileWithMap)[7:end])
    readline(fileWithMap)

    arrayWithMap = Array{String, 1}(undef, height)

    for i in 1:height
        arrayWithMap[i] = readline(fileWithMap)
    end

    print("Precise depart x-coordinate: ")
    start_x = parse(Int, readline())
    print("Precise depart y-coordinate: ")
    start_y = parse(Int, readline())
    print("Precise arrival x-coordinate: ")
    final_x = parse(Int, readline())
    print("Precise arrival y-coordinate: ")
    final_y = parse(Int, readline())

    println("The shortest path distance is: $(dijkstra(arrayWithMap, start_x, start_y, final_x, final_y))")
end
