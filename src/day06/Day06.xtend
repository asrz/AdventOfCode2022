package day06; 

import java.io.FileReader
import static extension com.google.common.io.CharStreams.*
import java.util.List
import static extension util.Extensions.*

class Day06 {
	def static getMarker(String line, int length) {
		for (i : length..line.length) {
			if (line.substring(i-length, i).chars.distinct.count == length) {
				return i
			}
		}
	}
	
	def static part1(List<String> lines) {
		val result = lines
			.map[ line | getMarker(line, 4) ]
				
		println(result)
	}
	
	def static part2(List<String> lines) {
		val result = lines
			.map[ line | getMarker(line, 14) ]
			 
		println(result)
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day06.in").readLines
			
		
		part1(lines)
		part2(lines)
	}
}
