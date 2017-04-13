package com.example.programmingpenguin.marioworld;

import android.app.ActionBar;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.List;

public class CharacterDetail extends ListActivity {

    private String characterType;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent intent = getIntent();
        characterType = intent.getStringExtra("characterType");
        ListView listCharacters = getListView();

        ArrayAdapter<Character>listAdapter;

        switch (characterType){
            case "Heroes":
                listAdapter = new ArrayAdapter<Character>(this, android.R.layout.simple_list_item_1, Character.heroes);
                break;
            case "Anti-Heroes":
                listAdapter = new ArrayAdapter<Character>(this, android.R.layout.simple_list_item_1, Character.anti);
                break;
            default:
                listAdapter = new ArrayAdapter<Character>(this, android.R.layout.simple_list_item_1, Character.villains);
        }

        listCharacters.setAdapter(listAdapter);

        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id) {
        Intent intent = new Intent(CharacterDetail.this, CharacterPicture.class);
        intent.putExtra("characterID", (int) id);
        intent.putExtra("characterType", characterType);
        startActivity(intent);
    }

    public boolean onCreateOptionsMenu(Menu menu){
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item){
        switch(item.getItemId()){
            case R.id.favorites:
                Intent intent = new Intent(this, FavoritesActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
