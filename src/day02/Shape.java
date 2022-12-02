package day02;

import java.util.Set;

enum Shape {
	ROCK(1, "A", "X"),
	PAPER(2, "B", "Y"),
	SCISSORS(3, "C", "Z"),
	;
	
	private int score;
	private Set<String> symbols;
	
	public int getScore() { return score; }
	public Set<String> getSymbols() { return symbols; }
	
	private Shape(int score, String... symbols) {
		this.score = score;
		this.symbols = Set.of(symbols);
	}
	
	public static Shape fromString(String symbol) {
		for (Shape shape : values()) {
			if (shape.getSymbols().contains(symbol)) {
				return shape;
			}
		}
		return null;
	}
	
	public static int getMatchScore(Shape theirs, Shape mine) {
		return getScore(theirs, mine) + mine.getScore();
	}
	
	private static int getScore(Shape theirs, Shape mine) {
		switch(theirs) {
			case ROCK: {
				switch(mine) {
					case PAPER: return 6;
					case ROCK: return 3;
					case SCISSORS: return 0;
				}
			}
			case PAPER: {
				switch(mine) {
					case PAPER: return 3;
					case ROCK: return 0;
					case SCISSORS: return 6;
				}
			}
			case SCISSORS: {
				switch(mine) {
					case PAPER: return 0;
					case ROCK: return 6;
					case SCISSORS: return 3;
				}
			}
		}
		
		throw new RuntimeException("Unexpected shapes");
	}
}