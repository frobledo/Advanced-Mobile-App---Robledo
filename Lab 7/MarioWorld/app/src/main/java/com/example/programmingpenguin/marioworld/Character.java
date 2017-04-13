package com.example.programmingpenguin.marioworld;

/**
 * Created by ProgrammingPenguin on 4/6/17.
 */

public class Character {

    private String name;
    private int imageResourceID;

    private Character(String newname, int newID){
        this.name = newname;
        this.imageResourceID = newID;
    }

    public static final Character[] heroes = {
            new Character("Mario", R.drawable.mario),
            new Character("Princess Peach", R.drawable.peach),
            new Character("Luigi", R.drawable.luigi),
            new Character("Yoshi", R.drawable.yoshi),
            new Character("Toad", R.drawable.toad)
    };

    public static final Character[] anti = {
            new Character("Wario", R.drawable.wario),
            new Character("Waluigi", R.drawable.waluigi),
            new Character("King Boo", R.drawable.boo),
            new Character("Nabbit", R.drawable.nabbit)
    };

    public static final Character[] villains = {
            new Character("Bowser", R.drawable.bowser),
            new Character("Spiny", R.drawable.spiny),
            new Character("Buzzy Beetle", R.drawable.beetle),
            new Character("Goomba", R.drawable.goomba)
    };

    public String getName(){
        return name;
    }

    public int getImageResourceID() {
        return imageResourceID;
    }

    public String toString() {
        return this.name; 
    }
}
