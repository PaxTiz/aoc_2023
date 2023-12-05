import strutils
import days/day1
import days/day2
import days/day3
import days/day4
import days/day5

when isMainModule:
    echo "Part 1: " & intToStr(day5.part1())
    echo "Part 2: " & intToStr(day5.part2())
