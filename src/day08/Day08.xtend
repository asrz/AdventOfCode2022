package day08;

import java.io.FileReader
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

import static extension com.google.common.io.CharStreams.*

class Day08 {
	
	@Accessors
	static class Tree {
		int height
		Boolean visibleN
		Boolean visibleS
		Boolean visibleW
		Boolean visibleE
		
		def isVisible() {
			return visibleN || visibleS || visibleE || visibleW
		}
	}
	
	def static part1(List<List<Integer>> grid) {
		val List<List<Tree>> trees = new ArrayList
		
		val height = grid.size
		val width = grid.get(0).size
		
		for (y : 0 ..< height) {
			val row = new ArrayList
			for (x : 0 ..< width) {
				val tree = new Tree()
				tree.height = grid.get(y).get(x)
				if (y == 0) {
					tree.visibleN = true
				}
				if (x == 0) {
					tree.visibleW = true
				}
				if (y == height-1) {
					tree.visibleS = true
				}
				if (x == width-1) {
					tree.visibleE = true
				}
				row.add(tree)
			}
			trees.add(row)
		}
		
		for (y : 1..< height) {
			for (x: 0 ..< width) {
				val tree = trees.get(y).get(x)
				var ny = y-1
				while (tree.visibleN === null && ny >= 0) {
					val neighbour = trees.get(ny--).get(x)
					if (neighbour.visibleN) {
						tree.visibleN = tree.height > neighbour.height
					}
				}
			}
		}
		
		for (y : height-1 >.. 0) {
			for (x: 0 ..< width) {
				val tree = trees.get(y).get(x)
				var ny = y+1
				while (tree.visibleS === null && ny < height) {
					val neighbour = trees.get(ny++).get(x)
					if (neighbour.visibleS) {
						tree.visibleS = tree.height > neighbour.height
					}
				}
			}
		}
		
		for (x: 1 ..< width) {
			for (y : 0 ..< height) {
				val tree = trees.get(y).get(x)
				var nx = x-1
				while (tree.visibleW === null && nx >= 0) {
					val neighbour = trees.get(y).get(nx--)
					if (neighbour.visibleW) {
						tree.visibleW = tree.height > neighbour.height
					}
				}
			}
		}
		
		for (x: width-1 >.. 0) {
			for (y : 0 ..< height) {
				val tree = trees.get(y).get(x)
				var nx = x+1
				while (tree.visibleE === null && nx < width) {
					val neighbour = trees.get(y).get(nx++)
					if (neighbour.visibleE) {
						tree.visibleE = tree.height > neighbour.height
					}
				}
			}
		}
		
		val result = trees.map [ row | row.filter[isVisible]].flatten.size
		
		println(result)
	}
	
	def static part2(List<List<Integer>> trees) {
		val height = trees.size
		val width = trees.get(0).size
		
		var maxScenic = 0
		
		for (y : 0 ..< height) {
			for (x : 0 ..< width) {
				val tree = trees.get(y).get(x)
				
				var blocked = y == 0
				var ny = y-1
				while(!blocked && ny >= 0) {
					val neighbour = trees.get(ny--).get(x)
					blocked = neighbour >= tree 
				}
				val north = y - ny - 1
				
				blocked = y == height-1
				ny = y+1
				while(!blocked && ny < height) {
					val neighbour = trees.get(ny++).get(x)
					blocked = neighbour >= tree
				}
				val south = ny - y - 1
				
				blocked = x == 0
				var nx = x-1
				while(!blocked && nx >= 0) {
					val neighbour = trees.get(y).get(nx--)
					blocked = neighbour >= tree
				}
				val west = x - nx - 1
				
				blocked = x == width - 1
				nx = x+1
				while(!blocked && nx < width) {
					val neighbour = trees.get(y).get(nx++)
					blocked = neighbour >= tree
				}
				val east = nx - x - 1
				
				val scenic = north * south * east * west
				
				maxScenic = Math.max(maxScenic, scenic)
			}
		}
		
		println(maxScenic)
	}
	
	def static void main(String[] args) {
		val grid = new FileReader("day08.in").readLines
			.map[toCharArray.map[ch | Character::getNumericValue(ch)]]
		
		
		part1(grid)
		part2(grid)
	}
}
