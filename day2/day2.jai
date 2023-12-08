#import "Basic";
#import "String";
#import "File";
#import "Text_File_Handler";

CubeGroup :: struct {
    count:  int;
    color:  string;
}

game_possible :: (line: string) -> bool {
    r_cubes := 12;
    g_cubes := 13;
    b_cubes := 14;
    while !begins_with(line, ":") advance(*line);
    advance(*line);
    advance(*line);
    // Multiple splits as below is most certainly not optimal
    games := split(line, "; ");
    for games {
        sets := split(it, ", ");
        for sets {
            cubes := split(it, " ");
            if cubes[1] == "red" && to_integer(cubes[0]) > r_cubes return false;
            if cubes[1] == "green" && to_integer(cubes[0]) > g_cubes return false;
            if cubes[1] == "blue" && to_integer(cubes[0]) > b_cubes return false;
        }
    }
    return true;
}

main :: () {
    args  := get_command_line_arguments();
    input :=  read_entire_file(args[1]);
    sum := 0;
    game_id := 1;
    while true {
        line, found := consume_next_line(*input);
        if !found break;
        if game_possible(line) sum += game_id;
        game_id += 1;
    }
    print("Sum: %\n", sum);
}
