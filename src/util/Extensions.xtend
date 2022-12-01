package util

import java.util.ArrayList

import java.util.List
import java.util.regex.Pattern

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
	
}