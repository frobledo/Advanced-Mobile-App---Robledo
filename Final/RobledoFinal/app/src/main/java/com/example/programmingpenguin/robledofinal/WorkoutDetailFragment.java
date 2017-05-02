package com.example.programmingpenguin.robledofinal;


import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import java.util.ArrayList;


/**
 * A simple {@link Fragment} subclass.
 */
public class WorkoutDetailFragment extends Fragment implements View.OnClickListener {

    private ArrayAdapter<String> adapter;
    private long settingId;
    private ButtonClickListener listener;

    public WorkoutDetailFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment

        if(savedInstanceState != null){
            settingId = savedInstanceState.getLong("settingId");
        }

        if(Exercise.work[0].getWorkout().size() == 0){
            Exercise.work[0].loadWorkouts(getActivity(),0);
        }

        if(Exercise.work[1].getWorkout().size() == 0){
            Exercise.work[1].loadWorkouts(getActivity(),1);
        }
        return inflater.inflate(R.layout.fragment_workout_detail, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();

        View view = getView();
        ListView listWorkout = (ListView) view.findViewById(R.id.workoutListView);
        ArrayList<String> workoutList = new ArrayList<String>();
        workoutList = Exercise.work[(int)settingId].getWorkout();
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, workoutList);

        listWorkout.setAdapter(adapter);
        Button addButton = (Button)view.findViewById(R.id.addButton);
        addButton.setOnClickListener(this);

        registerForContextMenu(listWorkout);
    }

    public void setSetting(long id){
        this.settingId = id;
    }

    @Override
    public void onSaveInstanceState(Bundle savedInstanceState){
        savedInstanceState.putLong("settingId", settingId);
    }

    interface ButtonClickListener{
        void addworkoutclicked(View view);
    }

    @Override
    public void onAttach(Context context){
        super.onAttach(context);
        listener = (ButtonClickListener) context;
    }

    @Override
    public void onClick(View view){
        if(listener != null){
            listener.addworkoutclicked(view);
        }
    }

    public void addworkout(){
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Workout");
        dialog.setCancelable(true);

        final EditText editText = (EditText) dialog.findViewById(R.id.editWorkout);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String workoutName = editText.getText().toString();
                Exercise.work[(int)settingId].getWorkout().add(workoutName);
                WorkoutDetailFragment.this.adapter.notifyDataSetChanged();
                Exercise.work[(int)settingId].storeWorkouts(getActivity(), settingId);
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String workoutName = adapter.getItem(adapterContextMenuInfo.position);
        menu.setHeaderTitle("Delete " + workoutName);

        menu.add(1,1,1,"Yes");
        menu.add(2,2,2, "No");
    }

    @Override
    public boolean onContextItemSelected(MenuItem item){
        int itemId = item.getItemId();

        if(itemId == 1){
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            Exercise.work[(int)settingId].getWorkout().remove(info.position);
            WorkoutDetailFragment.this.adapter.notifyDataSetChanged();
            Exercise.work[(int)settingId].storeWorkouts(getActivity(), settingId);
        }
        return true;
    }

}
