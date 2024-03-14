#!/usr/bin/env julia

println("Precise path to the file with map:")
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
end
