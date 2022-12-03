package AoC22.Day2;
// Super efficient RPS game inspired by Day 2 of AoC22

import java.util.HashMap;
public class RPS {
    public static void main(String[] args) {
        HashMap<String, Integer> letterToNumber = new HashMap<String, Integer>();
        letterToNumber.put("Rock", 1);
        letterToNumber.put("Paper", 2);
        letterToNumber.put("Scissor", 3);
        HashMap<Double, String> numberToPlay = new HashMap<Double, String>();
        numberToPlay.put(1.0, "Rock");
        numberToPlay.put(2.0, "Paper");
        numberToPlay.put(3.0, "Scissor");
        int opp = letterToNumber.get(args[0]);
        System.out.println(numberToPlay.get(Math.pow((3/2)*(opp),2)-6.5*(opp)+8));
    }
}