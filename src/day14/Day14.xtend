package day14;

import java.io.FileReader
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

import static extension com.google.common.io.CharStreams.*

class Day14 {
	@Data
	static class Point {
		int x
		int y
		
		new (List<Integer> pair) {
			this.x = pair.get(0)
			this.y = pair.get(1)
		}
	}
	
	def static part1(List<List<Point>> lines) {
		val minX = lines.flatten.map[x].min
		val maxX = lines.flatten.map[x].max
		val minY = 0
		val maxY = lines.flatten.map[y].max
		
		val grid = new ArrayList
		for (y : minY..maxY) {
			val row = new ArrayList
			for (x : minX..maxX) {
				row.add(".")
			}
			grid.add(row)
		}
		
		for (line : lines) {
			for (i : 1..<line.size) {
				val start = line.get(i-1)
				val end = line.get(i)
				
				if (start.x == end.x) {
					for (y : start.y..end.y) {
						grid.get(y).set(start.x-minX, "#")
					}
				} else {
					for (x : start.x..end.x) {
						grid.get(start.y).set(x-minX, "#")
					}
				}
			}
		}
		
		var inbounds = true
		var sand = 0
		val origin = new Point(#[500, 0])
		while(inbounds) {
			var x = origin.x - minX
			var y = origin.y
			
			var falling = true
			
			while (falling) {
				try {
					if (grid.get(y+1).get(x) == ".") {
						y += 1
					} else if (grid.get(y+1).get(x-1) == ".") {
						y += 1
						x -= 1
					} else if (grid.get(y+1).get(x+1) == ".") {
						y += 1
						x += 1
					} else {
						grid.get(y).set(x, "O")
						sand += 1
						falling = false
					}
				} catch (IndexOutOfBoundsException e) {
					inbounds = false
					falling = false
				}
			}
		}
		
		println(sand)
		
	}
	
	def static part2(List<List<Point>> lines) {
		val minY = 0
		val maxY = lines.flatten.map[y].max + 2
		val minX = Math.min(lines.flatten.map[x].min, 500 - maxY)
		val maxX = Math.max(lines.flatten.map[x].max, 500 + maxY)
		
		val grid = new ArrayList
		for (y : minY..maxY) {
			val row = new ArrayList
			for (x : minX..maxX) {
				row.add(".")
			}
			grid.add(row)
		}
		
		for (line : lines) {
			for (i : 1..<line.size) {
				val start = line.get(i-1)
				val end = line.get(i)
				
				if (start.x == end.x) {
					for (y : start.y..end.y) {
						grid.get(y).set(start.x-minX, "#")
					}
				} else {
					for (x : start.x..end.x) {
						grid.get(start.y).set(x-minX, "#")
					}
				}
			}
		}
		
		for (x : minX..maxX) {
			grid.get(maxY).set(x-minX, "#")
		}
		
		var inbounds = true
		var sand = 0
		val origin = new Point(#[500, 0])
		while(inbounds) {
			var x = origin.x - minX
			var y = origin.y
			
			var falling = true
			
			while (falling) {
				if (grid.get(y+1).get(x) == ".") {
					y += 1
				} else if (grid.get(y+1).get(x-1) == ".") {
					y += 1
					x -= 1
				} else if (grid.get(y+1).get(x+1) == ".") {
					y += 1
					x += 1
				} else {
					grid.get(y).set(x, "O")
					if (y == origin.y && x == origin.x - minX) {
						inbounds = false
					}
					sand += 1
					falling = false
				}
			}
		}
		
		println(sand)
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day14.in").readLines
			.map[split("->").map[strip].map[split(",").map[i | Integer.parseInt(i)]].map[l | new Point(l)]]
			
		part1(lines)
		part2(lines)
	}
}
