    using Images


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


    hashmap = Dict{Union{Char, String}, RGB{N0f8}}(
        '.' => colorant"white",
        'G' => colorant"white",
        '@' => colorant"black",
        'O' => colorant"black",
        'T' => colorant"green",
        'S' => colorant"saddlebrown",
        'W' => colorant"blue",
        "considered" => colorant"gray40",
        "visited" => colorant"gray25",
        "path" => colorant"gray10"
    )


    function mapToPNG(
        map::Array{Char, 2},
        filename::String
    )::Nothing

        rgbMap = Array{RGB{N0f8}, 2}(undef, size(map)[1], size(map)[2])
        for i in 1:size(map)[1]
            for j in 1:size(map)[2]
                rgbMap[i, j] = hashmap[map[i, j]]
            end
        end
        save("out/$filename.png", rgbMap)

    end


    function mapToPNG(
        mapInfo::Array{MapPoint, 2},
        final_y::Int, final_x::Int,
        filename::String
    )::Nothing
        
        rgbMap = Array{RGB{N0f8}, 2}(undef, size(mapInfo)[1], size(mapInfo)[2])
        for i in 1:size(mapInfo)[1]
            for j in 1:size(mapInfo)[2]
                if mapInfo[i, j].isVisited
                    rgbMap[i, j] = hashmap["visited"]
                elseif mapInfo[i, j].isConsidered
                    rgbMap[i, j] = hashmap["considered"]
                else
                    rgbMap[i, j] = hashmap[mapInfo[i, j].terrainType]
                end
            end
        end
        current_y = final_y
        current_x = final_x
        while mapInfo[current_y, current_x].previousLocation != (0, 0)
            rgbMap[current_y, current_x] = hashmap["path"]
            y = current_y
            current_y = mapInfo[current_y, current_x].previousLocation[1]
            current_x = mapInfo[y, current_x].previousLocation[2]
        end
        rgbMap[current_y, current_x] = hashmap["path"]
        save("out/$filename.png", rgbMap)

    end
