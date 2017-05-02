package com.example.programmingpenguin.robledofinal;

import android.app.ActionBar;
import android.app.Activity;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

public class MainActivity extends Activity implements SettingListFragment.SettingListListener, WorkoutDetailFragment.ButtonClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);
    }

    @Override
    public void itemClicked(long id){

        View fragmentContainer = findViewById(R.id.fragment_container);
        if(fragmentContainer != null){
            WorkoutDetailFragment fragment = new WorkoutDetailFragment();
            FragmentTransaction fragmentTransaction = getFragmentManager().beginTransaction();
            fragment.setSetting(id);
            fragmentTransaction.replace(R.id.fragment_container, fragment);
            fragmentTransaction.addToBackStack(null);
            fragmentTransaction.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE);
            fragmentTransaction.commit();
        } else{
            Intent intent = new Intent(this,DetailActivity.class);
            intent.putExtra("id", (int)id);
            startActivity(intent);
        }
    }

    @Override public void onBackPressed(){
        if(getFragmentManager().getBackStackEntryCount()>0){
            getFragmentManager().popBackStack();
        } else{
            super.onBackPressed();
        }
    }

    @Override
    public void addworkoutclicked(View view){
        WorkoutDetailFragment fragment = (WorkoutDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addworkout();
    }

    public boolean onCreateOptionsMenu(Menu menu){
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item){
        switch(item.getItemId()){
            case R.id.register:
                Intent intent = new Intent(this, OrderActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
