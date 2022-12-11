package util

import java.util.ArrayList

import java.util.List
import java.util.regex.Pattern
import java.util.regex.Matcher

class Extensions {
	
	def static <T> split(List<T> list, T separator) {
		val List<List<T>> subLists = new ArrayList
		var List<T> subList = new ArrayList
		for (T element : list) {
			if (element == separator) {
				subLists += subList
				subList = new ArrayList
			} else {
				subList += element
			}
		}
		return subLists
	}
	
	def static reSplit(List<String> list, String regex) {
		val List<List<String>> subLists = new ArrayList
		var List<String> subList = new ArrayList
		
		for (String element : list) {
			if (Pattern.matches(regex, element)) {
				subLists += subList
				subList = new ArrayList
			} else {
				subList += element
			}
		}
		return subLists
	}
	
	def static reSplit2(List<String> list, String regex) {
		val Pattern pattern = Pattern.compile(regex)
		val result = new ArrayList
		result.add(new ArrayList)
		list.fold(result) [nestedList, word | 
			if (pattern.matcher(word).matches) {
				nestedList.add(new ArrayList)
			} else {
				nestedList.last.add(word)
			}
			
			return nestedList
		]
	}
	
	def static <T> List<List<T>> partition(List<T> list, int partitionSize) {
		val List<List<T>> result = new ArrayList
		
		var int i = 0
		var List<T> subList = new ArrayList
		for (T element : list) {
			subList.add(element)
			i++
			if (i % partitionSize == 0) {
				result.add(subList)
				subList = new ArrayList<T>
			}
		}
		
		return result
	}
	
	def static List<String> groups(Matcher matcher) {
		if (matcher.matches) {
			return (1 .. matcher.groupCount).map[ i | matcher.group(i) ].toList
		}
	}
	
	def static List<String> partition(String input, int partitionSize) {
		val List<String> result = new ArrayList
		
		for(var i = 0; i < input.length; i += partitionSize) {
			result.add(input.substring(i, i+partitionSize-1))
		}
		
		return result
	}
	
	def static String slice(String input, int beginIndex) {
		return slice(input, beginIndex, input.length)
	}
	
	def static String slice(String input, int beginIndex, int endIndex) {
		var i = beginIndex
		var j = endIndex
		if (beginIndex < 0) {
			i = beginIndex + input.length
		}
		if (endIndex < 0) {
			j += input.length
		}
		
		return input.substring(i, j)
	}
	
}
