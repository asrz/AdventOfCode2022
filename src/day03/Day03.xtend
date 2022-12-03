package day03; 

import java.io.FileReader
import static extension com.google.common.io.CharStreams.*
import java.util.List
import static extension util.Extensions.*

class Day03 {
	def static getPriority(char c) {
		return Character.getNumericValue(c) - 9 + (Character.isUpperCase(c) ? 26 : 0)
	}
	
	def static part1(List<String> lines) {
		val score = lines.map[ line | line.substring(0, line.length/2) -> line.substring(line.length/2) ]
		.map[ pair | pair.key.toCharArray.findFirst[ c | pair.value.indexOf(c) != -1 ]]
		.map[getPriority]
		.reduce[ a,b | a+b ]
		
		println(score)
	}
	
	def static part2(List<String> lines) {
		val result = lines.partition(3)
		.map[ list | list.get(0).toCharArray.findFirst[c | list.get(1).indexOf(c) != -1 && list.get(2).indexOf(c) != -1]]
		.map[getPriority]
		.reduce[ a,b | a+b ]
		
		println(result)
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day03.in").readLines
		
		part1(lines)
		part2(lines)
	}
}
