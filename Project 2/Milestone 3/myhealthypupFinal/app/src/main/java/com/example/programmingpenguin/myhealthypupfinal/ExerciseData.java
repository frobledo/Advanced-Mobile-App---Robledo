package com.example.programmingpenguin.myhealthypupfinal;


/**
 * Created by ProgrammingPenguin on 4/16/17.
 */

public class ExerciseData {

    private String date;
    private String time;
    private String length;
    private String place;

    public ExerciseData(String date, String time, String length, String place){
        this.date = date;
        this.time = time;
        this.length = length;
        this.place = place;
    }

    public String getDate(){
        return date;
    }

    public void setDate(String date){
        this.date = date;
    }

    public String getTime(){
        return time;
    }

    public void setTime(String time){
        this.time = time;
    }

    public String getLength(){
        return length;
    }

    public void getLength(String length){
        this.length = length;
    }

    public String getPlace(){
        return place;
    }

    public void setPlace(String place){
        this.place = place;
    }



}

