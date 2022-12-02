package day02;

import static day02.Shape.*;

enum Result {
	LOSS("X", 0),
	DRAW("Y", 3),
	WIN("Z", 6),
	;
	
	private String symbol;
	private int score;
	
	public String getSymbol() { return symbol; }
	public int getScore() { return score; }
	
	private Result(String symbol, int score) {
		this.symbol = symbol;
		this.score = score;
	}
	
	public static Result fromString(String symbol) {
		for (Result result : values()) {
			if (result.symbol.equals(symbol)) {
				return result;
			}
		}
		
		throw new RuntimeException("Unknown symbol: " + symbol);
	}
	
	public static Shape getShape(Shape theirs, Result result) {
		switch(theirs) {
			case ROCK: {
				switch(result) {
					case LOSS: return SCISSORS;
					case DRAW: return ROCK;
					case WIN: return PAPER;
				}
			}
			case PAPER: {
				switch(result) {
					case LOSS: return ROCK;
					case DRAW: return PAPER;
					case WIN: return SCISSORS;
				}
			}
			case SCISSORS: {
				switch(result) {
					case LOSS: return PAPER;
					case DRAW: return SCISSORS;
					case WIN: return ROCK;
				}
			}
		}
		
		throw new RuntimeException("Unexpected shape or result");
	}
}
