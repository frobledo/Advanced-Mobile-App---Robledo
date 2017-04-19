package com.example.programmingpenguin.myhealthypupfinal;


/**
 * Created by ProgrammingPenguin on 4/16/17.
 */

public class HealthDietData {

    private String date;
    private String type;
    private String notes;

    public HealthDietData(String date, String type, String notes){
        this.date = date;
        this.type = type;
        this.notes = notes;
    }

    public String getDate(){
        return date;
    }

    public void setDate(String date){
        this.date = date;
    }

    public String getType(){
        return type;
    }

    public void setType(String time){
        this.type = type;
    }

    public String getNotes(){
        return notes;
    }

    public void getNotes(String notes){
        this.notes = notes;
    }

}

