package com.example.programmingpenguin.mybooks;

import com.google.firebase.database.Exclude;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by ProgrammingPenguin on 4/27/17.
 */

public class BookItem {

    public String name;
    public String url;

    public BookItem(){

    }


    public BookItem(String newName, String newURL){
        name = newName;
        url = newURL;
    }

    public String getName(){
        return name;
    }

    public String getUrl(){
        return url;
    }

    @Exclude
    public Map<String,Object> toMap(){
        HashMap<String,Object> result = new HashMap<>();
        result.put("name", name);
        result.put("url", url);
        return result;
    }

    public String toString() {
        return this.name;
    }
}
