#!/usr/bin/env julia

# TODO: fix need to include mapProperties
# TODO: considered points count

module main
    include("pathFinding.jl")
    using .pathFinding

    include("mapOperations.jl")
    using .mapOperations

    include("clApp.jl")
    using .clApp

    export algoDijkstra, algoAstar, clDijkstra, clAStar

    function algoDijkstra(
        fname::String,
        D::Tuple{Int64, Int64},
        A::Tuple{Int64, Int64}
    )::Nothing
        x = waStar(loadMapFromFile(fname), D[1], D[2], A[1], A[2], 0.0)
        println("The shortest found distance is: ", x[1][A[2], A[1]].distanceFromStart)
        # println("Considered points: ", count(x[1][1:end, 1:end].isConsidered))
    end

    function algoAstar(
        fname::String,
        D::Tuple{Int64, Int64},
        A::Tuple{Int64, Int64}
    )::Nothing
        x = waStar(loadMapFromFile(fname), D[1], D[2], A[1], A[2], 0.5)
        println("The shortest found distance is: ", x[1][A[2], A[1]].distanceFromStart)
        # println("Considered points: ", count(x[1][1:end, 1:end].isConsidered))
    end
end
