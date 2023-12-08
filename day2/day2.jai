#import "Basic";
#import "String";
#import "File";
#import "Text_File_Handler";

game_possible_power :: (line: string) -> bool, int {
    r_cubes :: 12;
    g_cubes :: 13;
    b_cubes :: 14;
    r_max := 0;
    g_max := 0;
    b_max := 0;
    while !begins_with(line, ":") advance(*line);
    advance(*line);
    advance(*line);
    // Multiple splits as below is most certainly not optimal
    sets := split(line, "; ");
    for sets {
        tuples := split(it, ", ");
        for tuples {
            tuple := split(it, " ");
            if tuple[1] == "red" r_max = max(r_max, to_integer(tuple[0]));
            else if tuple[1] == "green" g_max = max(g_max, to_integer(tuple[0]));
            else if tuple[1] == "blue" b_max = max(b_max, to_integer(tuple[0]));
        }
    }
    return r_max <= r_cubes && g_max <= g_cubes && b_max <= b_cubes, r_max*g_max*b_max;
}

main :: () {
    args  := get_command_line_arguments();
    input :=  read_entire_file(args[1]);
    sum_possible := 0;
    sum_power := 0;
    game_id := 1;
    while true {
        line, found := consume_next_line(*input);
        if !found break;
        possible, power := game_possible_power(line);
        if possible sum_possible += game_id;
        sum_power += power;
        game_id += 1;
    }
    print("Sum Possible: %, Sum Power: %\n", sum_possible, sum_power);
}
