module pathFinding

    mutable struct MapPoint
        terrainType::Char
        isVisited::Bool
        distance::Float32
        previousLocation::Tuple{Int, Int}

        function MapPoint(terrainType::Char)
            return new(terrainType, false, Inf32, (0, 0))
        end
    end

    export dijkstra

    function dijkstra(
        map::Array{Char, 2},
        start_x::Int, start_y::Int,
        final_x::Int, final_y::Int
    )::Int

        # Terrain start and finish check
        if isTerrainExplorable(map[start_y, start_x]) == false || isTerrainExplorable(map[final_y, final_x]) == false
            throw(ArgumentError("Invalid map coordinates: Unpassable terrain"))
        end

        # Size for mapInfo
        height = size(map, 1)
        width = size(map, 2)

        # Info about map initially unknown
        mapInfo = Array{MapPoint, 2}(undef, height, width)
        for i in 1:height
            for j in 1:width
                mapInfo[i, j] = MapPoint(map[i, j])
            end  
        end

        # Starting position
        mapInfo[start_y, start_x].distance = 0

        # Array of reachable points
        reachableLocations = Array{Tuple{Int, Int}}(undef, 0)
        push!(reachableLocations, (start_y, start_x))

        while !isempty(reachableLocations)
            
            # Closest location as new current location
            min_distance = mapInfo[reachableLocations[1][1], reachableLocations[1][2]].distance
            min_i = 1
            for i in 2:size(reachableLocations, 1)
                if min_distance > mapInfo[reachableLocations[i][1], reachableLocations[i][2]].distance
                    min = mapInfo[reachableLocations[1][1], reachableLocations[1][2]].distance
                    min_i = i
                end
            end
            current_x = reachableLocations[min_i][2]
            current_y = reachableLocations[min_i][1]
            mapInfo[current_y, current_x].isVisited = true

            # Distance initialisation, Array push for currently reachable locations
            if current_x-1 >= 1 &&
            isTerrainExplorable(mapInfo[current_y, current_x-1].terrainType) &&
            mapInfo[current_y, current_x-1].isVisited == false &&
            mapInfo[current_y, current_x-1].distance > mapInfo[current_y, current_x].distance + 1
                    mapInfo[current_y, current_x-1].distance = mapInfo[current_y, current_x].distance + 1
                    mapInfo[current_y, current_x-1].previousLocation = (current_y, current_x)
                    push!(reachableLocations, (current_y, current_x-1))
            end
            if current_y-1 >= 1 &&
                isTerrainExplorable(mapInfo[current_y-1, current_x].terrainType) &&
                mapInfo[current_y-1, current_x].isVisited == false &&
                mapInfo[current_y-1, current_x].distance > mapInfo[current_y, current_x].distance + 1
                        mapInfo[current_y-1, current_x].distance = mapInfo[current_y, current_x].distance + 1
                        mapInfo[current_y-1, current_x].previousLocation = (current_y, current_x)
                        push!(reachableLocations, (current_y-1, current_x))
            end
            if current_x+1 <= width &&
                isTerrainExplorable(mapInfo[current_y, current_x+1].terrainType) &&
                mapInfo[current_y, current_x+1].isVisited == false &&
                mapInfo[current_y, current_x+1].distance > mapInfo[current_y, current_x].distance + 1
                        mapInfo[current_y, current_x+1].distance = mapInfo[current_y, current_x].distance + 1
                        mapInfo[current_y, current_x+1].previousLocation = (current_y, current_x)
                        push!(reachableLocations, (current_y, current_x+1))
            end
            if current_y+1 <= height &&
                isTerrainExplorable(mapInfo[current_y+1, current_x].terrainType) &&
                mapInfo[current_y+1, current_x].isVisited == false &&
                mapInfo[current_y+1, current_x].distance > mapInfo[current_y, current_x].distance + 1
                        mapInfo[current_y+1, current_x].distance = mapInfo[current_y, current_x].distance + 1
                        mapInfo[current_y+1, current_x].previousLocation = (current_y, current_x)
                        push!(reachableLocations, (current_y+1, current_x))
            end

            # Analyse of current location finished
            deleteat!(reachableLocations, min_i)
            mapInfo[current_y, current_x].isVisited = true

        end

        if mapInfo[final_y, final_x].distance != Inf32
            return mapInfo[final_y, final_x].distance
        else
            throw(ArgumentError("No possible path"))
        end
        
    end

    function isTerrainExplorable(c::Char)::Bool
        if c == '@' || c == 'O' || c == 'T'
            return false
        elseif c == '.' || c == 'G' || c == 'S' || c == 'W'
            return true
        else
            throw(ArgumentError("Invalid map argument"))
        end
    end

end
