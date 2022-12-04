package AoC22.Day2;
// Super efficient RPS game inspired by Day 2 of AoC22

import java.util.HashMap;
public class RPS {
    public static void main(String[] args) {
        HashMap<String, Double> letterToNumber = new HashMap<String, Double>();
        letterToNumber.put("Rock", 1.0);
        letterToNumber.put("Paper", 2.0);
        letterToNumber.put("Scissor", 3.0);
        HashMap<Double, String> numberToPlay = new HashMap<Double, String>();
        numberToPlay.put(1.0, "Rock");
        numberToPlay.put(2.0, "Paper");
        numberToPlay.put(3.0, "Scissor");
        Double opp = letterToNumber.get(args[0]);
        System.out.println(numberToPlay.get((3.0/2.0)*Math.pow(opp,2.0)-6.5*opp+8.0));
    }
}