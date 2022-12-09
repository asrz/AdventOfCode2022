package day09;

import java.io.FileReader
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set

import static extension com.google.common.io.CharStreams.*

class Day09 {
	def static part1(List<String> lines) {
		val Set<Pair<Integer, Integer>> tailVisited = new HashSet
		tailVisited.add(0 -> 0)
		
		var headX = 0
		var headY = 0
		var tailX = 0
		var tailY = 0
		
		for (instruction : lines.map[split(" ")]) {
			val direction = instruction.get(0)
			val number = Integer.parseInt(instruction.get(1))
			
			for (i : 0..<number) {
				switch(direction) {
					case "R": headX++
					case "L": headX--
					case "U": headY++
					case "D": headY--
				}
				
				if (Math.abs(headX - tailX) > 1 || Math.abs(headY - tailY) > 1) {
					//move tail
					if (headX > tailX) {
						tailX += 1
					}
					if (headX < tailX) {
						tailX -= 1
					}
					if (headY > tailY) {
						tailY += 1
					}
					if (headY < tailY) {
						tailY -= 1
					}
				}
				tailVisited.add(tailX -> tailY)
			}
		}
		
		println(tailVisited.size)
		
	}
	
	def static part2(List<String> lines) {
		val Set<Pair<Integer, Integer>> tailVisited = new HashSet 
		tailVisited.add(0 -> 0)
		
		val ropeX = new ArrayList
		val ropeY = new ArrayList
		
		for (i : 0..<10) {
			ropeX.add(0)
			ropeY.add(0)
		}
		
		for (instruction : lines.map[split(" ")]) {
			val direction = instruction.get(0)
			val number = Integer.parseInt(instruction.get(1))
			
			for (i : 0..<number) {
				var headX = ropeX.get(0)
				var headY = ropeY.get(0)
				
				switch(direction) {
					case "R": ropeX.set(0, headX+1)
					case "L": ropeX.set(0, headX-1)
					case "U": ropeY.set(0, headY+1)
					case "D": ropeY.set(0, headY-1)
				}
				
				for (j : 1..<ropeX.size) {
					headX = ropeX.get(j-1)
					headY = ropeY.get(j-1)
					var tailX = ropeX.get(j)
					var tailY = ropeY.get(j)
					
					
					if (Math.abs(headX - tailX) > 1 || Math.abs(headY - tailY) > 1) {
						//move tail
						if (headX > tailX) {
							ropeX.set(j, tailX+1)
						}
						if (headX < tailX) {
							ropeX.set(j, tailX-1)
						}
						if (headY > tailY) {
							ropeY.set(j, tailY+1)
						}
						if (headY < tailY) {
							ropeY.set(j, tailY-1)
						}
					}
				}
				
				tailVisited.add(ropeX.get(9) -> ropeY.get(9))
			}
			
		}
		
		println(tailVisited.size)
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day09.in").readLines
		
		part1(lines)
		part2(lines)
	}
}
