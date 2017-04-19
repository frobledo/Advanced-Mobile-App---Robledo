package com.example.programmingpenguin.myhealthypupfinal;

import android.app.Dialog;
import android.support.v4.app.Fragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.Spinner;
import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by ProgrammingPenguin on 4/15/17.
 */

public class Exercise extends Fragment implements Serializable {

    ArrayList<ExerciseData> exerciseInformation = new ArrayList<>();
    ExerciseListAdapter adapter;
    ListView exerciseList;

    public Exercise() {
        // Required empty public constructor
    }

    @Override
    public void onStart() {

        super.onStart();

        View view = getView();
        exerciseList = (ListView) view.findViewById(R.id.exercise_list);

        adapter = new ExerciseListAdapter(getActivity(), R.layout.exercise_adapter_view, exerciseInformation);
        exerciseList.setAdapter(adapter);

        //Button to add exercise information to list
        ImageButton addButton = (ImageButton) view.findViewById(R.id.add_activity);
        View.OnClickListener onclick = new View.OnClickListener(){
            public void onClick(View view){

                addExercise(view);
            }
        };
        addButton.setOnClickListener(onclick);

        registerForContextMenu(exerciseList);
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, Bundle savedInstanceState) {

        //To deal with device rotation
        if(savedInstanceState != null){
            exerciseInformation = (ArrayList<ExerciseData>)savedInstanceState.getSerializable("exerciseInformation");
        }

        return inflater.inflate(R.layout.exercise_tab, container, false);

    }

    //As of now, this does not work properly. Still debugging for Project 3
    @Override
    public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;

        ExerciseData exerciseInformation = adapter.getItem(adapterContextMenuInfo.position);

        menu.setHeaderTitle("DELETE ENTRY?");
        menu.add(1,1,1,"Yes");
        menu.add(2,2,2,"No");

        System.out.println("end of method");
    }

    @Override
    public boolean onContextItemSelected(MenuItem item){
        System.out.println("on context item selected method");

        int itemID = item.getItemId();

        if (itemID == 1){

            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            System.out.println("this is info" + info.position);
            exerciseInformation.remove(info.position);
            System.out.println("this is the size" + exerciseInformation.size());
            Exercise.this.adapter.notifyDataSetChanged();
        }

        return true;
    }

    //To deal with device rotation
    @Override
    public void onSaveInstanceState(Bundle outState){
        super.onSaveInstanceState(outState);
        outState.putSerializable("exerciseInformation", exerciseInformation);
    }


    //Method executed when add button is pressed
    public void addExercise(View view) {

        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.add_exercise);
        dialog.setCancelable(true);

        final DatePicker add_date_picker = (DatePicker) dialog.findViewById(R.id.datePicker);
        final Spinner time_info = (Spinner) dialog.findViewById(R.id.spinner_time);
        final EditText add_place = (EditText) dialog.findViewById(R.id.editPlace);
        final Spinner length_info = (Spinner) dialog.findViewById(R.id.spinner);

        Button button = (Button) dialog.findViewById(R.id.save_button);
        button.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                String new_date = getDatePicker(add_date_picker);
                String new_time = getTimeSpinner(time_info);
                String new_length = getLengthSpinner(length_info);
                String new_place = add_place.getText().toString();

                ExerciseData add_new = new ExerciseData(new_date, new_time, new_length, new_place);

                exerciseInformation.add(0, add_new);
                System.out.println(exerciseInformation.size());
                adapter = new ExerciseListAdapter(getActivity(), R.layout.exercise_adapter_view, exerciseInformation);
                exerciseList.setAdapter(adapter);

                dialog.dismiss();

            }
        });

        dialog.show();
    }

    //The three methods below obtain date from the pickers
    public String getDatePicker(DatePicker add_date_picker){

        int month = add_date_picker.getMonth();
        int day = add_date_picker.getDayOfMonth();
        int year = add_date_picker.getYear();
        String new_date = (month+1) + "/" + day + "/" + year;

        return new_date;
    }

    public String getTimeSpinner(Spinner time_info){

        Integer spinnerSelection_time = time_info.getSelectedItemPosition();
        String new_time = "";

        switch(spinnerSelection_time) {
            case 0:
                new_time = "";
                break;
            case 1:
                new_time = "Morning";
                break;
            case 2:
                new_time = "Afternoon";
                break;
            case 3:
                new_time = "Evening";
                break;
        }

        return new_time;

    }

    public String getLengthSpinner(Spinner length_info){

        Integer spinnerSelection = length_info.getSelectedItemPosition();
        String new_length = "";

        switch(spinnerSelection){
            case 0:
                new_length = "";
                break;
            case 1:
                new_length = "10 minutes";
                break;
            case 2:
                new_length = "20 minutes";
                break;
            case 3:
                new_length = "30 minutes";
                break;
            case 4:
                new_length = "40 minutes";
                break;
            case 5:
                new_length = "50 minutes";
                break;
            case 6:
                new_length = "1 hour";
                break;
            case 7:
                new_length = "1.5 hours";
                break;
            case 8:
                new_length = ">1.5 hours";
                break;
        }

        return new_length;
    }

}
