import strutils
import days/day1
import days/day2
import days/day3
import days/day4
import days/day5
import days/day6

when isMainModule:
    echo "Part 1: " & intToStr(day6.part1())
    echo "Part 2: " & intToStr(day6.part2())
