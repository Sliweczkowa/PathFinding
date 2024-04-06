module pathFinding
    export dijkstra

    function dijkstra(
        map::Array{String, 1},
        start_x::Int, start_y::Int,
        final_x::Int, final_y::Int
        )::Int

        if isExplorable(map[start_y][start_x]) == false ||isExplorable(map[final_y][final_x]) == false
            throw(ArgumentError("Invalid map coordinates: Unpassable terrain"))
        end

        current_x = start_x
        current_y = start_y

        height = length(map)
        width = length(map[1])

        # best distance cost, for every field, but strating point, initially unknown
        distance = fill(Inf32, (height, width))
        distance[start_y, start_x] = 0

        # best previous location, for every field initially unknown
        # TODO: while drawing, do not forget that indexing in Julia starts at 1
        previousLocation = fill((0, 0), (height, width))

        # entire map, excluding starting point, initially unexplored
        isExplored = fill(false, (height, width))           
        isExplored[start_y, start_x] = true

        # array of possible destinations, initially empty
        avaiableLocations = Array{Tuple{Int, Int}}(undef, 0)

        while isExplored[final_y, final_x] == 0
            if current_x > 1 &&
                isExplorable(map[current_y][current_x-1]) &&
                isExplored[current_y, current_x-1] == 0 &&
                distance[current_y, current_x] + 1 < distance[current_y, current_x-1]
                    distance[current_y, current_x-1] = distance[current_y, current_x] + 1
                    push!(avaiableLocations, (current_y, current_x-1))
            end
            if current_y > 1 &&
                isExplorable(map[current_y-1][current_x]) &&
                isExplored[current_y-1, current_x] == 0 &&
                distance[current_y, current_x] + 1 < distance[current_y-1, current_x]
                    distance[current_y-1, current_x] = distance[current_y, current_x] + 1
                    push!(avaiableLocations, (current_y-1, current_x))
            end
            if current_x < length(map[1]) &&
                isExplorable(map[current_y][current_x+1]) &&
                isExplored[current_y, current_x+1] == 0 &&
                distance[current_y, current_x] + 1 < distance[current_y, current_x+1]
                    distance[current_y, current_x+1] = distance[current_y, current_x] + 1
                    push!(avaiableLocations, (current_y, current_x+1))
            end
            if current_y < length(map) &&
                isExplorable(map[current_y+1][current_x]) &&
                isExplored[current_y+1, current_x] == 0 &&
                distance[current_y, current_x] + 1 < distance[current_y+1, current_x]
                    distance[current_y+1, current_x] = distance[current_y, current_x] + 1
                    push!(avaiableLocations, (current_y+1, current_x))
            end
            min = distance[avaiableLocations[1][1], avaiableLocations[1][2]]
            min_i = 1
            for i in 2:length(avaiableLocations)
                if min > distance[avaiableLocations[i][1], avaiableLocations[i][2]]
                    min = distance[avaiableLocations[i][1], avaiableLocations[i][2]]
                    min_i = i
                end
            end
            previous_x = current_x
            previous_y = current_y
            current_x = avaiableLocations[min_i][2]
            current_y = avaiableLocations[min_i][1]
            deleteat!(avaiableLocations, min_i)
            isExplored[current_y, current_x] = true
            previousLocation[current_y, current_x] = (previous_y, previous_x)
        end

        return distance[final_y, final_x]
    end

    function isExplorable(c::Char)::Bool
        if c == '@' || c == 'O' || c == 'T'
            return false
        elseif c == '.' || c == 'G' || c == 'S' || c == 'W'
            return true
        else
            throw(ArgumentError("Invalid map argument"))
        end
    end

end
