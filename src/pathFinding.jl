function waStar(
    map::Array{Char, 2},
    start_x::Int, start_y::Int,
    final_x::Int, final_y::Int,
    weight::Float64
)::Tuple{Array{MapPoint, 2}, Int, Int}

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
            mapInfo[i, j].distanceToFinal = abs(final_x - j) + abs(final_y - i)
        end  
    end

    # Starting position
    mapInfo[start_y, start_x].distanceFromStart = 0

    # Array of reachable points
    reachableLocations = Array{Tuple{Int, Int}}(undef, 0)
    push!(reachableLocations, (start_y, start_x))

    while !mapInfo[final_y, final_x].isVisited
        
        # Weight dependant choice
        min_distance = (1 - weight) * (mapInfo[reachableLocations[1][1], reachableLocations[1][2]].distanceFromStart) + weight * (mapInfo[reachableLocations[1][1], reachableLocations[1][2]].distanceToFinal)
        min_i = 1
        for i in 2:size(reachableLocations, 1)
            if min_distance > (1 - weight) * (mapInfo[reachableLocations[i][1], reachableLocations[i][2]].distanceFromStart) + weight * (mapInfo[reachableLocations[i][1], reachableLocations[i][2]].distanceToFinal)
                min_distance = (1 - weight) * (mapInfo[reachableLocations[i][1], reachableLocations[i][2]].distanceFromStart) + weight * (mapInfo[reachableLocations[i][1], reachableLocations[i][2]].distanceToFinal)
                min_i = i
            end
        end
        current_x = reachableLocations[min_i][2]
        current_y = reachableLocations[min_i][1]
        mapInfo[current_y, current_x].isVisited = true

        # Distance initialisation, Array push for currently reachable locations
        if current_x-1 > 1 &&
        isTerrainExplorable(mapInfo[current_y, current_x-1].terrainType) &&
        mapInfo[current_y, current_x-1].isVisited == false &&
        mapInfo[current_y, current_x-1].distanceFromStart > mapInfo[current_y, current_x].distanceFromStart + hashmap1[mapInfo[current_y, current_x-1].terrainType]
                mapInfo[current_y, current_x-1].distanceFromStart = mapInfo[current_y, current_x].distanceFromStart + hashmap1[mapInfo[current_y, current_x-1].terrainType]
                mapInfo[current_y, current_x-1].previousLocation = (current_y, current_x)
                push!(reachableLocations, (current_y, current_x-1))
                mapInfo[current_y, current_x-1].isConsidered = true
        end
        if current_y-1 > 1 &&
            isTerrainExplorable(mapInfo[current_y-1, current_x].terrainType) &&
            mapInfo[current_y-1, current_x].isVisited == false &&
            mapInfo[current_y-1, current_x].distanceFromStart > mapInfo[current_y, current_x].distanceFromStart + hashmap1[mapInfo[current_y-1, current_x].terrainType]
                    mapInfo[current_y-1, current_x].distanceFromStart = mapInfo[current_y, current_x].distanceFromStart + hashmap1[mapInfo[current_y-1, current_x].terrainType]
                    mapInfo[current_y-1, current_x].previousLocation = (current_y, current_x)
                    push!(reachableLocations, (current_y-1, current_x))
                    mapInfo[current_y-1, current_x].isConsidered = true
        end
        if current_x+1 < width &&
            isTerrainExplorable(mapInfo[current_y, current_x+1].terrainType) &&
            mapInfo[current_y, current_x+1].isVisited == false &&
            mapInfo[current_y, current_x+1].distanceFromStart > mapInfo[current_y, current_x].distanceFromStart + hashmap1[mapInfo[current_y, current_x+1].terrainType]
                    mapInfo[current_y, current_x+1].distanceFromStart = mapInfo[current_y, current_x].distanceFromStart + hashmap1[mapInfo[current_y, current_x+1].terrainType]
                    mapInfo[current_y, current_x+1].previousLocation = (current_y, current_x)
                    push!(reachableLocations, (current_y, current_x+1))
                    mapInfo[current_y, current_x+1].isConsidered = true
        end
        if current_y+1 < height &&
            isTerrainExplorable(mapInfo[current_y+1, current_x].terrainType) &&
            mapInfo[current_y+1, current_x].isVisited == false &&
            mapInfo[current_y+1, current_x].distanceFromStart > mapInfo[current_y, current_x].distanceFromStart + hashmap1[mapInfo[current_y+1, current_x].terrainType]
                    mapInfo[current_y+1, current_x].distanceFromStart = mapInfo[current_y, current_x].distanceFromStart + hashmap1[mapInfo[current_y+1, current_x].terrainType]
                    mapInfo[current_y+1, current_x].previousLocation = (current_y, current_x)
                    push!(reachableLocations, (current_y+1, current_x))
                    mapInfo[current_y+1, current_x].isConsidered = true
        end

        # Analyse of current location finished
        deleteat!(reachableLocations, min_i)
        mapInfo[current_y, current_x].isVisited = true

    end

    if mapInfo[final_y, final_x].distanceFromStart  != Inf32
        return mapInfo, final_y, final_x
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

hashmap1 = Dict{Char, Float64}(
    '.' => 1.0,
    'G' => 1.0,
    '@' => Inf64,
    'O' => Inf64,
    'T' => Inf64,
    'S' => 5.0,
    'W' => 8.0
)
