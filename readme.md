# Pathfinding Algorithms Implementation

## A little bit about the project

This project implements two pathfinding algorithms: Dijkstra's Algorithm and A* in Julia.
The program consists in finding the shortest path between two points on a map while avoiding obstacles either by command line or CLI application.

## Prerequisites

1. Julia programming language (version 1.9 or higher)

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## How to set up and use this program

1. Clone this repository to your local machine
2. Open the terminal and navigate to project directory 
3. Prepare a .map file according to the format on the following site *https://movingai.com/benchmarks/formats.html* and a path to it
4. Run *julia* and add the main file with *include("src/main.jl")* and *using .main* commands
5. You can now use algorithms directly:
    - algoDijkstra(path_to_file::String, start_coordinates::Tuple{Int64, Int64}, finish_coordinates::Tuple{Int64, Int64})
    - algoAStar(path_to_file::String, start_coordinates::Tuple{Int64, Int64}, finish_coordinates::Tuple{Int64, Int64})

    or by command line interface:
    - clDijkstra()
    - clAStar()

## Known issues (Work in progress)

### Limited Support for Map Features
The pathfinding algorithm currently supports basic map features such as passable terrain and obstacles. Additional features such as different terrain types (water, swamp, ect.) may not be fully supported.

### Input Validation
The project currently performs minimal input validation, which may lead to unexpected behavior or errors when providing invalid input. Future updates could enhance input validation to provide better error handling.

### Platform Compatibility
The project has been tested on Linux only, therefore there may be compatibility issues or differences in behavior on other platforms.

### Lack of Unit Tests

The project currently lacks comprehensive unit tests to validate the correctness and robustness of the implemented algorithms and features. Without proper test coverage, there is a higher risk of undetected bugs or regressions in the codebase. Future updates will include the addition of unit tests to ensure the reliability and stability of the project.
