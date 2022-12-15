package day15;

import java.io.FileReader
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.regex.Pattern

import static extension com.google.common.io.CharStreams.*
import static extension util.Extensions.*

class Day15 {
	
	static class RangeList {
		val ranges = new ArrayList<IntegerRange>
		
		def add(IntegerRange range) {
			var toAdd = range
			val toRemove = new ArrayList<IntegerRange>
			for (other : ranges) {
				if (toAdd.start <= other.end && toAdd.end >= other.start) {
					toAdd = (Math.min(toAdd.start, other.start)..Math.max(toAdd.end, other.end))
					toRemove.add(other)
				} else if (toAdd.start >= other.start && toAdd.end <= other.end) {
					return //already contained
				} else if (other.start >= toAdd.start && other.end <= toAdd.end) {
					toRemove.add(other) // contained in new range
				} else if (toAdd.end == other.start - 1) {
					toAdd = toAdd.start..other.end
					toRemove.add(other)
				} else if (toAdd.start == other.end + 1) {
					toAdd = other.start..toAdd.end
					toRemove.add(other)
				}
			}
			
			ranges.removeAll(toRemove)
			ranges.add(toAdd)
		}
		
		def size() {
			return ranges.size
		}
		
		def min() {
			return ranges.map[start].min
		}
		
		def max() {
			return ranges.map[end].max
		}
		
		def findX() {
			if (size != 2) {
				println("More than 2 ranges!")
				return null
			}
			
			val range1 = ranges.get(0)
			val range2 = ranges.get(1)
			if (range1.start < range2.start) {
				if (range1.end == range2.start - 2) {
					return range1.end + 1
				}
			} else {
				if (range2.end == range1.start - 2) {
					return range2.end + 1
				}
			}
			
			return null
		}
		
		override toString() {
			return ranges.map[range | String.format("(%d..%d)", range.start, range.end)].join(", ")
		}
	}
	
	def static getBadX(List<List<Integer>> lines, int targetY, boolean countBeacons) {
		val badX = new HashSet<Integer>
		val goodX = new HashSet<Integer>
		
		for (List<Integer> line : lines) {
			val sensorX = line.get(0)
			val sensorY = line.get(1)
			val beaconX = line.get(2)
			val beaconY = line.get(3)
			
			if (beaconY == targetY) {
				goodX.add(beaconX)
			}
			
			val distance = Math.abs(sensorX - beaconX) + Math.abs(sensorY - beaconY)
			
			var excess = distance - Math.abs(targetY - sensorY)
			if (excess > 0) {
				((sensorX - excess)..(sensorX + excess)).forEach[x | badX.add(x)]
			}
		}
		
		if (!countBeacons) {
			badX.removeAll(goodX)
		}
		
		return badX
	}
	
	def static part1(List<List<Integer>> lines) {
		val targetY = 2000000
		
		val badX = getBadX(lines, targetY, false)
		
		println(badX.size)
	}
	
	def static getBeacons(List<List<Integer>> lines) {
		return lines.map[line | line.get(2) -> line.get(3)]
	}
	
	def static part2(List<List<Integer>> lines, int max) {
		for (y : 0..max) {
			val ranges = new RangeList
			
			for (List<Integer> line : lines) {
				
				val sensorX = line.get(0)
				val sensorY = line.get(1)
				val beaconX = line.get(2)
				val beaconY = line.get(3)
				
				if (beaconY == y) {
					ranges.add(beaconX..beaconX)
				}
				
				val distance = Math.abs(sensorX - beaconX) + Math.abs(sensorY - beaconY)
				
				var excess = distance - Math.abs(y - sensorY)
				if (excess > 0) {
					val range = (sensorX - excess)..(sensorX + excess)
					ranges.add(range)
				}
				
			}
			
			if (ranges.size == 1 && ranges.min <= 0 && ranges.max >= max) {
				
			} else {
				val x = ranges.findX as long
				println(x * max + y)
				return
			}
			
		}
	}
	
	
	def static void main(String[] args) {
		val pattern = Pattern.compile("Sensor at x=(-?\\d+), y=(-?\\d+): closest beacon is at x=(-?\\d+), y=(-?\\d+)")
		val lines = new FileReader("day15.in").readLines
		.map[line | pattern.matcher(line).groups.map[x | Integer.parseInt(x)]]
		
		
		val millis = System.currentTimeMillis
		part1(lines)
		val part1 = System.currentTimeMillis
		part2(lines, 4000000)
		val part2 = System.currentTimeMillis
		
		println("Part1: " + (part1 - millis) + " ms")
		println("Part1: " + (part2 - part1) + " ms")
	}
}
