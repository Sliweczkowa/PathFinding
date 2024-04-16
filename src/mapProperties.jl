module mapProperties
    using Images

    export MapPoint

    mutable struct MapPoint
        terrainType::Char
        isConsidered::Bool
        isVisited::Bool
        distanceFromStart::Float32
        distanceToFinal::Int32
        previousLocation::Tuple{Int, Int}

        function MapPoint(terrainType::Char)
            return new(terrainType, false, false, Inf32, 0, (0, 0))
        end
    end
    
end