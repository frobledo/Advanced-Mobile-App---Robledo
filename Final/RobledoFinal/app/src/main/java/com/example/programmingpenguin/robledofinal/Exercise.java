package com.example.programmingpenguin.robledofinal;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by ProgrammingPenguin on 5/2/17.
 */

public class Exercise {

    private String setting;
    private ArrayList<String> workout = new ArrayList<>();

    private Exercise(String set, ArrayList<String>work){
        this.setting = set;
        this.workout = new ArrayList<String>(work);
    }

    public static final Exercise[] work = {
            new Exercise("Indoors", new ArrayList<String>()),
            new Exercise("Outdoors", new ArrayList<String>())
    };

    public String getSetting(){
        return setting;
    }

    public ArrayList<String> getWorkout(){
        return workout;
    }

    public String toString(){
        return this.setting;
    }

    public void storeWorkouts(Context context, long settingId){
        SharedPreferences sharedPreferences = context.getSharedPreferences("Workout", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();

        Set<String> set = new HashSet<String>();
        set.addAll(work[(int)settingId].getWorkout());
        editor.putStringSet(work[(int)settingId].getSetting(), set);
        editor.commit();
    }

    public void loadWorkouts(Context context, int settingId){
        SharedPreferences sharedPreferences = context.getSharedPreferences("Workout", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();

        Set<String> set = sharedPreferences.getStringSet(work[settingId].getSetting(), null);

        if(set != null){
            Exercise.work[settingId].workout.addAll(set);
        } else{
            switch(settingId){
                case 0:
                    Exercise.work[0].workout.addAll(Arrays.asList("Swimming", "Basketball"));
                    break;
                case 1:
                    Exercise.work[1].workout.addAll(Arrays.asList("Hiking", "Cycling"));
                    break;
                default:
                    break;
            }
        }
    }
}
