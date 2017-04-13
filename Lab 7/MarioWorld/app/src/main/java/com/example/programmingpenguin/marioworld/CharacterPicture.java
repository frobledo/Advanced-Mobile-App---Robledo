package com.example.programmingpenguin.marioworld;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.media.Image;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

public class CharacterPicture extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_character_picture);

        int characterNum = (Integer)getIntent().getExtras().get("characterID");
        String type = (String)getIntent().getExtras().get("characterType");

        Character character;
        ImageView characterImage;
        TextView characterName;


        switch (type){

            case "Heroes":

                character = Character.heroes[characterNum];
                characterImage = (ImageView)findViewById(R.id.characterImage);
                characterImage.setImageResource(character.getImageResourceID());
                characterName = (TextView)findViewById(R.id.characterID);
                characterName.setText(character.getName());
                break;

            case "Anti-Heroes":

                character = Character.anti[characterNum];
                characterImage = (ImageView)findViewById(R.id.characterImage);
                characterImage.setImageResource(character.getImageResourceID());
                characterName = (TextView)findViewById(R.id.characterID);
                characterName.setText(character.getName());
                break;

            default:

                character = Character.villains[characterNum];
                characterImage = (ImageView)findViewById(R.id.characterImage);
                characterImage.setImageResource(character.getImageResourceID());
                characterName = (TextView)findViewById(R.id.characterID);
                characterName.setText(character.getName());
        }

        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);
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
