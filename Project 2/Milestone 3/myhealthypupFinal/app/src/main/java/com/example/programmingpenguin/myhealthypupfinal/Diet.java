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

import com.google.firebase.database.DatabaseReference;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by ProgrammingPenguin on 4/15/17.
 */

public class Diet extends Fragment implements Serializable {

    ArrayList<HealthDietData> dietInformation = new ArrayList<>();
    HealthDietListAdapter adapter;
    ListView dietList;
    private DatabaseReference mDatabase;

    public Diet() {
        // Required empty public constructor
    }


    @Override
    public void onStart() {

        super.onStart();

        View view = getView();
        dietList = (ListView) view.findViewById(R.id.diet_list);

        adapter = new HealthDietListAdapter(getActivity(), R.layout.diet_vet_adapter_view, dietInformation);
        dietList.setAdapter(adapter);

        ImageButton addButton = (ImageButton) view.findViewById(R.id.add_activity);
        View.OnClickListener onclick = new View.OnClickListener(){
            public void onClick(View view){

                addDiet(view);
            }
        };
        addButton.setOnClickListener(onclick);

        registerForContextMenu(dietList);

    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, Bundle savedInstanceState) {

        if(savedInstanceState != null){
            dietInformation = (ArrayList<HealthDietData>)savedInstanceState.getSerializable("dietInformation");
        }

        return inflater.inflate(R.layout.diet_tab, container, false);

    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;

        HealthDietData dietInformation = adapter.getItem(adapterContextMenuInfo.position);

        menu.setHeaderTitle("DELETE ENTRY?");
        menu.add(1,1,1,"Yes");
        menu.add(2,2,2,"No");
    }

    @Override public boolean onContextItemSelected(MenuItem item){
        int itemID = item.getItemId();


        if (itemID == 1){
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            System.out.println(info);
            dietInformation.remove(info.position);
            Diet.this.adapter.notifyDataSetChanged();
        }

        return true;
    }

    @Override
    public void onSaveInstanceState(Bundle outState){
        super.onSaveInstanceState(outState);
        outState.putSerializable("dietInformation", dietInformation);
    }

    public void addDiet(View view) {

        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.add_diet);
        dialog.setCancelable(true);

        final DatePicker add_date_picker = (DatePicker) dialog.findViewById(R.id.datePicker);
        final Spinner type_info = (Spinner) dialog.findViewById(R.id.food_spinner);
        final EditText add_notes = (EditText) dialog.findViewById(R.id.food_notes_view);

        Button button = (Button) dialog.findViewById(R.id.save_button);
        button.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                String new_date = getDatePicker(add_date_picker);
                String new_type = getTypeSpinner(type_info);
                String new_notes = add_notes.getText().toString();

                HealthDietData add_new = new HealthDietData(new_date, new_type, new_notes);

                dietInformation.add(0, add_new);
                adapter = new HealthDietListAdapter(getActivity(), R.layout.diet_vet_adapter_view, dietInformation);
                dietList.setAdapter(adapter);

                dialog.dismiss();

            }
        });

        dialog.show();
    }

    public String getDatePicker(DatePicker add_date_picker){

        int month = add_date_picker.getMonth();
        int day = add_date_picker.getDayOfMonth();
        int year = add_date_picker.getYear();
        String new_date = (month+1) + "/" + day + "/" + year;

        return new_date;
    }

    public String getTypeSpinner(Spinner type_info){

        Integer spinnerSelection = type_info.getSelectedItemPosition();
        String new_type = "";

        switch(spinnerSelection) {
            case 0:
                new_type = "";
                break;
            case 1:
                new_type = "Treat";
                break;
            case 2:
                new_type = "Breakfast";
                break;
            case 3:
                new_type = "Lunch";
                break;
            case 4:
                new_type = "Dinner";
                break;
        }

        return new_type;

    }

}
