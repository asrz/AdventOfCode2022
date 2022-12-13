package day12;

import java.io.FileReader
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

import static extension com.google.common.io.CharStreams.*

class Day12 {
	@Data
	static class Point {
		int x
		int y
	}
	
	def static getDistance(List<List<Integer>> distances, Point point) {
		distances.get(point.y).get(point.x)
	}
	
	def static setDistance(List<List<Integer>> distances, Point point, int distance) {
		distances.get(point.y).set(point.x, distance)
	}
	
	def static char getHeight(List<char[]> grid, Point point) {
		val height = grid.get(point.y).get(point.x)
		if (height == "S".charAt(0)) {
			return 'a'
		} else if (height == "E".charAt(0)) {
			return 'z'
		} else {
			return height
		}
	}
	
	def static part1(List<char[]> grid) {
		var Point start
		var Point end
		val List<List<Integer>> distances = new ArrayList
		
		
		for (i : 0..<grid.size) {
			val row = grid.get(i)
			distances.add(new ArrayList)
			for (j : 0..<row.size) {
				distances.get(i).add(0)
				if (row.get(j) == 'S'.charAt(0)) {
					start = new Point(j,i)
				} else if (row.get(j) == 'E'.charAt(0)) {
					end = new Point(j,i)
				}
			}
		}
		
		val List<Point> boundry = new ArrayList
		boundry.add(start)
		setDistance(distances, start, 1)
		
		while(!boundry.empty) {
			val curr = boundry.remove(0)
			val currHeight = getHeight(grid, curr)
			
			if (curr.x > 0) {
				val next = new Point(curr.x-1, curr.y)
				val nextHeight = getHeight(grid, next)
				
				if (currHeight - nextHeight >= -1) {
					if (getDistance(distances, next) == 0) {
						boundry.add(next)
						setDistance(distances, next, getDistance(distances, curr)+1)
					} else {
						setDistance(distances, next, Math.min(getDistance(distances, curr)+1, getDistance(distances, next)))
					}
				}
			}
			if (curr.x < grid.get(0).size-1) {
				val next = new Point(curr.x+1, curr.y)
				val nextHeight = getHeight(grid, next)
				
				if (currHeight - nextHeight >= -1) {
					if (getDistance(distances, next) == 0) {
						boundry.add(next)
						setDistance(distances, next, getDistance(distances, curr)+1)
					} else {
						setDistance(distances, next, Math.min(getDistance(distances, curr)+1, getDistance(distances, next)))
					}
				}
			}
			if (curr.y > 0) {
				val next = new Point(curr.x, curr.y-1)
				val nextHeight = getHeight(grid, next)
				
				if (currHeight - nextHeight >= -1) {
					if (getDistance(distances, next) == 0) {
						boundry.add(next)
						setDistance(distances, next, getDistance(distances, curr)+1)
					} else {
						setDistance(distances, next, Math.min(getDistance(distances, curr)+1, getDistance(distances, next)))
					}
				}
			}
			if (curr.y < grid.size-1) {
				val next = new Point(curr.x, curr.y+1)
				val nextHeight = getHeight(grid, next)
				
				if (currHeight - nextHeight >= -1) {
					if (getDistance(distances, next) == 0) {
						boundry.add(next)
						setDistance(distances, next, getDistance(distances, curr)+1)
					} else {
						setDistance(distances, next, Math.min(getDistance(distances, curr)+1, getDistance(distances, next)))
					}
				}
			}
		}
		
		println(getDistance(distances, end)-1)
	}
	
	def static part2(List<char[]> grid) {
		var Point end
		val List<List<Integer>> distances = new ArrayList
		
		
		for (i : 0..<grid.size) {
			val row = grid.get(i)
			distances.add(new ArrayList)
			for (j : 0..<row.size) {
				distances.get(i).add(0)
				if (row.get(j) == 'E'.charAt(0)) {
					end = new Point(j,i)
				}
			}
		}
		
		val List<Point> boundry = new ArrayList
		boundry.add(end)
		setDistance(distances, end, 1)
		
		while(!boundry.empty) {
			val curr = boundry.remove(0)
			val currHeight = getHeight(grid, curr)
			
			if (curr.x > 0) {
				val next = new Point(curr.x-1, curr.y)
				val nextHeight = getHeight(grid, next)
				
				if (currHeight - nextHeight <= 1) {
					if (getDistance(distances, next) == 0) {
						boundry.add(next)
						setDistance(distances, next, getDistance(distances, curr)+1)
					} else {
						setDistance(distances, next, Math.min(getDistance(distances, curr)+1, getDistance(distances, next)))
					}
				}
			}
			if (curr.x < grid.get(0).size-1) {
				val next = new Point(curr.x+1, curr.y)
				val nextHeight = getHeight(grid, next)
				
				if (currHeight - nextHeight <= 1) {
					if (getDistance(distances, next) == 0) {
						boundry.add(next)
						setDistance(distances, next, getDistance(distances, curr)+1)
					} else {
						setDistance(distances, next, Math.min(getDistance(distances, curr)+1, getDistance(distances, next)))
					}
				}
			}
			if (curr.y > 0) {
				val next = new Point(curr.x, curr.y-1)
				val nextHeight = getHeight(grid, next)
				
				if (currHeight - nextHeight <= 1) {
					if (getDistance(distances, next) == 0) {
						boundry.add(next)
						setDistance(distances, next, getDistance(distances, curr)+1)
					} else {
						setDistance(distances, next, Math.min(getDistance(distances, curr)+1, getDistance(distances, next)))
					}
				}
			}
			if (curr.y < grid.size-1) {
				val next = new Point(curr.x, curr.y+1)
				val nextHeight = getHeight(grid, next)
				
				if (currHeight - nextHeight <= 1) {
					if (getDistance(distances, next) == 0) {
						boundry.add(next)
						setDistance(distances, next, getDistance(distances, curr)+1)
					} else {
						setDistance(distances, next, Math.min(getDistance(distances, curr)+1, getDistance(distances, next)))
					}
				}
			}
		}
		
		var int minDistance = Integer.MAX_VALUE
		
		for (y : 0..<grid.size) {
			for (x : 0..<grid.get(0).size) {
				val height = grid.get(y).get(x)
				val distance = distances.get(y).get(x)
				if (height == 'a'.charAt(0) && distance != 0) {
					minDistance = Math.min(minDistance, distance)
				}
			}
		}
		
		println(minDistance-1)
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day12.in").readLines.map[toCharArray]
		
		part1(lines)
		part2(lines)
	}
}
