package com.example.programmingpenguin.divergent;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by ProgrammingPenguin on 4/13/17.
 */

public class Character {

    private String faction;
    private ArrayList<String>characters = new ArrayList<>();

    private Character(String fact, ArrayList<String>people){
        this.faction = fact;
        this.characters = new ArrayList<String>(people);
    }

    public static final Character[] people = {
            new Character("Abnegation", new ArrayList<String>()),
            new Character("Dauntless", new ArrayList<String>()),
            new Character("Amity", new ArrayList<String>()),
            new Character("Erudite", new ArrayList<String>()),
            new Character("Candor", new ArrayList<String>())
    };

    public String getFaction(){
        return faction;
    }

    public ArrayList<String> getCharacters(){
        return characters;
    }

    public String toString() {
        return this.faction;
    }

    public void storeCharacters(Context context, long factionID){

        SharedPreferences sharedPreferences = context.getSharedPreferences("Characters", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();

        Set<String>set = new HashSet<String>();

        set.addAll(people[(int)factionID].getCharacters());
        editor.putStringSet(people[(int)factionID].getFaction(), set);
        editor.commit();
    }

    public void loadCharacters(Context context, int factionID){

        SharedPreferences sharedPreferences = context.getSharedPreferences("Characters", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();

        Set<String>set = sharedPreferences.getStringSet(people[factionID].getFaction(), null);

        if(set != null){
           Character.people[factionID].characters.addAll(set);
        }

        else{

            switch(factionID){

                case 0:
                    Character.people[0].characters.addAll(Arrays.asList("Natalie Prior", "Susan Black", "Marcus Eaton"));
                    break;

                case 1:
                    Character.people[1].characters.addAll(Arrays.asList("Tris Prior", "Tobias Eaton", "Christina"));
                    break;

                case 2:
                    Character.people[2].characters.addAll(Arrays.asList("Robert Black", "Johanna Reyes"));
                    break;

                case 3:
                    Character.people[3].characters.addAll(Arrays.asList("Caleb Prior", "Jeanine Matthews", "Cara"));
                    break;

                case 4:
                    Character.people[4].characters.addAll(Arrays.asList("Jack Kang", "Bobby", "James Tucker"));
                    break;

                default:
                    break;
            }
        }
    }
}
