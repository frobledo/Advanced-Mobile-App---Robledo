package com.example.programmingpenguin.divergent;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class DetailActivity extends Activity implements CharacterDetailFragment.ButtonClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        CharacterDetailFragment characterDetailFragment = (CharacterDetailFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        int factionID = (int)getIntent().getExtras().get("id");

        characterDetailFragment.setFaction(factionID);
    }

    @Override
    public void addCharacterClicked(View view){

        CharacterDetailFragment fragment = (CharacterDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addCharacter();
    }
}
