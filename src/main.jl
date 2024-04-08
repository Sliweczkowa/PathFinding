#!/usr/bin/env julia

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
    )::Void
        dijkstra(loadMapFromFile(fname), D[2], D[1], A[2], A[1])
    end

    function algoAstar(
        fname::String,
        D::Tuple{Int64, Int64},
        A::Tuple{Int64, Int64}
    )::Void
        aStar(loadMapFromFile(fname), D[2], D[1], A[2], A[1])
    end
end
