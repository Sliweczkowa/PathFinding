module mapOperations
    export loadMapFromFile, displayMap

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

    function displayMap(
        map::Array{Char, 2}
    )::Nothing

        for i in 1:size(map, 1)
            print(join(map[i, 1:end]), '\n')
        end
    end

end