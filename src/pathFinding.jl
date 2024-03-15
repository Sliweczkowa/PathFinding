module pathFinding
    export dijkstra

    function dijkstra(map::Array{String, 1})
        # TODO: check if coordinates are passable and int
        print("Precise depart x-coordinate: ")
        start_x = parse(Int, readline())
        print("Precise depart y-coordinate: ")
        start_y = parse(Int, readline())
        print("Precise arrival x-coordinate: ")
        final_x = parse(Int, readline())
        print("Precise arrival y-coordinate: ")
        final_y = parse(Int, readline())

        current_x = start_x
        current_y = start_y

        height = length(map)
        width = length(map[1])

        distance = fill(Inf32, (height, width))
        distance[start_y, start_x] = 0
        previousLocation = fill((0, 0), (height, width))
        isExplored = fill(false, (height, width))
        isExplored[start_y, start_x] = true

        l = Array{Tuple{Int, Int}}(undef, 0)

        while isExplored[final_y, final_x] == 0
            if current_x > 1 &&
                map[current_y][current_x-1] != '@' &&
                map[current_y][current_x-1] != 'O' &&
                map[current_y][current_x-1] != 'T' &&
                isExplored[current_y, current_x-1] == 0 &&
                distance[current_y, current_x] + 1 < distance[current_y, current_x-1]
                    distance[current_y, current_x-1] = distance[current_y, current_x] + 1
                    push!(l, (current_y, current_x-1))
            end
            if current_y > 1 &&
                map[current_y-1][current_x] != '@' &&
                map[current_y-1][current_x] != 'O' &&
                map[current_y-1][current_x] != 'T' &&
                isExplored[current_y-1, current_x] == 0 &&
                distance[current_y, current_x] + 1 < distance[current_y-1, current_x]
                    distance[current_y-1, current_x] = distance[current_y, current_x] + 1
                    push!(l, (current_y-1, current_x))
            end
            if current_x < length(map[1]) &&
                map[current_y][current_x+1] != '@' &&
                map[current_y][current_x+1] != 'O' &&
                map[current_y][current_x+1] != 'T' &&
                isExplored[current_y, current_x+1] == 0 &&
                distance[current_y, current_x] + 1 < distance[current_y, current_x+1]
                    distance[current_y, current_x+1] = distance[current_y, current_x] + 1
                    push!(l, (current_y, current_x+1))
            end
            if current_y < length(map) &&
                map[current_y+1][current_x] != '@' &&
                map[current_y+1][current_x] != 'O' &&
                map[current_y+1][current_x] != 'T' &&
                isExplored[current_y+1, current_x] == 0 &&
                distance[current_y, current_x] + 1 < distance[current_y+1, current_x]
                    distance[current_y+1, current_x] = distance[current_y, current_x] + 1
                    push!(l, (current_y+1, current_x))
            end
            min = distance[l[1][1], l[1][2]]
            min_i = 1
            for i in 2:length(l)
                if min > distance[l[i][1], l[i][2]]
                    min = distance[l[i][1], l[i][2]]
                    min_i = i
                end
            end
            previous_x = current_x
            previous_y = current_y
            current_x = l[min_i][2]
            current_y = l[min_i][1]
            deleteat!(l, min_i)
            isExplored[current_y, current_x] = true
            previousLocation[current_y, current_x] = (previous_y, previous_x)
        end

        println("The shortest path distance is: $(distance[final_y, final_x])")

        # TODO: add penalty for water and swamp
    end
end
