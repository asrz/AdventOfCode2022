package day06; 

import java.io.FileReader
import static extension com.google.common.io.CharStreams.*
import java.util.List
import static extension util.Extensions.*

class Day06 {
	def static part1(List<String> lines) {
		val result = lines
			.map[ line | 
					for (i : 4..line.length) {
						if (line.substring(i-4, i).chars.distinct.count == 4) {
							return i
						}
					}
				]
				
		println(result)
	}
	
	def static part2(List<String> lines) {
		val result = lines
			.map[ line | 
					for (i : 14..line.length) {
						if (line.substring(i-14, i).chars.distinct.count == 14) {
							return i
						}
					}
				]
				
		println(result)
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day06.in").readLines
			
		
		part1(lines)
		part2(lines)
	}
}
