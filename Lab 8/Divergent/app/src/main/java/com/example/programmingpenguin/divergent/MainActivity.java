package com.example.programmingpenguin.divergent;

import android.app.Activity;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity implements FactionListFragment.FactionListListener, CharacterDetailFragment.ButtonClickListener{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    public void itemClicked(long id){



        View fragmentContainer = findViewById(R.id.fragment_container);

        if(fragmentContainer != null){

            CharacterDetailFragment fragment = new CharacterDetailFragment();
            FragmentTransaction ft = getFragmentManager().beginTransaction();
            fragment.setFaction(id);
            ft.replace(R.id.fragment_container, fragment);
            ft.addToBackStack(null);
            ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE);
            ft.commit();
        }

        else{

            Intent intent = new Intent(this, DetailActivity.class);
            intent.putExtra("id", (int)id);
            startActivity(intent);
        }

    }


    @Override
    public void onBackPressed(){

        if(getFragmentManager().getBackStackEntryCount() > 0) {
            getFragmentManager().popBackStack();
        } else{
            super.onBackPressed();
        }
    }

    @Override
    public void addCharacterClicked(View view){

        CharacterDetailFragment fragment = (CharacterDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addCharacter();
    }
}
