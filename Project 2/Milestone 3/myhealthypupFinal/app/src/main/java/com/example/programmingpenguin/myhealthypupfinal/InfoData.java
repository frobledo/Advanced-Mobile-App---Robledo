package com.example.programmingpenguin.myhealthypupfinal;

/**
 * Created by ProgrammingPenguin on 4/17/17.
 */

public class InfoData {

    private String name;
    private String age;
    private String breed;
    private String vet_name;
    private String vet_phone;

    public InfoData(String name, String age, String breed, String vet_name, String vet_phone) {
        this.name = name;
        this.age = age;
        this.breed = breed;
        this.vet_name = vet_name;
        this.vet_phone = vet_phone;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    public String getAge(){
        return age;
    }

    public void setAge(String age){
        this.age = age;
    }

    public String getBreed(){
        return breed;
    }

    public void setBreed(String breed){
        this.breed = breed;
    }

    public String getVet_name(){
        return vet_name;
    }

    public void setVet_name (String vet_name){
        this.vet_name = vet_name;
    }

    public String getVet_phone(){
        return vet_phone;
    }

    public void setVet_phone (String vet_phone){
        this.vet_phone = vet_phone;
    }
}
