module clApp
    include("pathFinding.jl")
    using .pathFinding

    include("mapOperations.jl")
    using .mapOperations

    export clDijkstra, clAStar

    function clDijkstra()::Nothing
        print("Precise path to the file with map: ")
        pathToFile = readline();

        print("Precise depart x-coordinate: ")
        start_x = parse(Int, readline())
        print("Precise depart y-coordinate: ")
        start_y = parse(Int, readline())
        print("Precise arrival x-coordinate: ")
        final_x = parse(Int, readline())
        print("Precise arrival y-coordinate: ")
        final_y = parse(Int, readline())

        println("The shortest path distance is: $(dijkstra(loadMapFromFile(pathToFile), start_x, start_y, final_x, final_y))")
    end
    
    function clAStar()::Nothing
        print("Precise path to the file with map: ")
        pathToFile = readline();

        print("Precise depart x-coordinate: ")
        start_x = parse(Int, readline())
        print("Precise depart y-coordinate: ")
        start_y = parse(Int, readline())
        print("Precise arrival x-coordinate: ")
        final_x = parse(Int, readline())
        print("Precise arrival y-coordinate: ")
        final_y = parse(Int, readline())

        println("The shortest path distance is: $(aStar(loadMapFromFile(pathToFile), start_x, start_y, final_x, final_y))")
    end
end
