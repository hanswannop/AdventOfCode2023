#import "Basic";
#import "String";
#import "File";
#import "Text_File_Handler";

calibration_value :: (line: string, use_words: bool = false) -> int {
    digit_names :: string.["one","two","three","four","five","six","seven","eight","nine"];
    start := 0;
    end := 0;
    while(line.count){
        for 0..8{
            digit := it+1;
            if begins_with(line, sprint("%", digit)) || (use_words && begins_with(line, digit_names[it])) {
                if start == 0 start = digit;
                end = digit;
            }
        }
        advance(*line);
    }
    return start*10 + end;
}

main :: () {
    args  := get_command_line_arguments();
    input :=  read_entire_file(args[1]);
    sum_pt1 := 0;
    sum_pt2 := 0;
    while true {
        line, found := consume_next_line(*input);
        if !found break;
        sum_pt1 += calibration_value(line);
        sum_pt2 += calibration_value(line, true);
    }
    print("Part 1: % Part 2: %\n", sum_pt1, sum_pt2);
}
