package com.example.programmingpenguin.robledofinal;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class DetailActivity extends Activity implements  WorkoutDetailFragment.ButtonClickListener{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        WorkoutDetailFragment workoutDetailFragment = (WorkoutDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        int settingId = (int)getIntent().getExtras().get("id");
        workoutDetailFragment.setSetting(settingId);

        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);
    }

    @Override
    public void addworkoutclicked(View view){
        WorkoutDetailFragment fragment = (WorkoutDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addworkout();
    }

}
