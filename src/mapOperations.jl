module mapOperations
    using Images
    import Main.mapProperties

    export loadMapFromFile, mapToPNG

    function loadMapFromFile(
        pathToFile::String
    )::Array{Char, 2}

        open(pathToFile) do fileWithMap        
            readline(fileWithMap)
            height = parse(Int32, readline(fileWithMap)[8:end])
            width = parse(Int32, readline(fileWithMap)[7:end])
            readline(fileWithMap)
        
            arrayWithMap = Array{Char, 2}(undef, height, width)
        
            for i in 1:height
                arrayWithMap[i, 1:end] = collect(readline(fileWithMap))
            end

            return arrayWithMap
        end
    end

    function mapToPNG(
        map::Array{Char, 2},
        filename::String
    )::Nothing

        hashmap = Dict{Char, RGB{N0f8}}(
            '.' => colorant"white",
            'G' => colorant"white",
            '@' => colorant"black",
            'O' => colorant"black",
            'T' => colorant"green",
            'S' => colorant"saddlebrown",
            'W' => colorant"blue"
        )

        rgbMap = Array{RGB{N0f8}, 2}(undef, size(map)[1], size(map)[2])
        for i in 1:size(map)[1]
            for j in 1:size(map)[2]
                rgbMap[i, j] = hashmap[map[i, j]]
            end
        end
        save("out/$filename.png", rgbMap)

    end

end