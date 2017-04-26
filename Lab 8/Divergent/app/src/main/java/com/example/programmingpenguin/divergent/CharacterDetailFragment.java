package com.example.programmingpenguin.divergent;


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
import java.util.jar.Pack200;


/**
 * A simple {@link Fragment} subclass.
 */
public class CharacterDetailFragment extends Fragment implements View.OnClickListener{

    private ArrayAdapter<String> adapter;
    private long factionID;
    private ButtonClickListener listener;

    public CharacterDetailFragment() {
        // Required empty public constructor
    }

    @Override
    public void onStart(){
        super.onStart();

        View view = getView();
        ListView listCharacters = (ListView) view.findViewById(R.id.characterListView);

        ArrayList<String> characterlist = new ArrayList<String>();
        characterlist = Character.people[(int) factionID].getCharacters();

        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, characterlist);

        listCharacters.setAdapter(adapter);

        Button addButton = (Button) view.findViewById(R.id.addButton);
        addButton.setOnClickListener(this);

        registerForContextMenu(listCharacters);
    }

    public void setFaction(long id){
        this.factionID = id;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        if(Character.people[0].getCharacters().size() == 0){
            Character.people[0].loadCharacters(getActivity(),0);
        }

        if(Character.people[1].getCharacters().size() == 0){
            Character.people[1].loadCharacters(getActivity(),1);
        }

        if(Character.people[2].getCharacters().size() == 0){
            Character.people[2].loadCharacters(getActivity(),2);
        }

        if(Character.people[3].getCharacters().size() == 0){
            Character.people[3].loadCharacters(getActivity(),3);
        }

        if(Character.people[4].getCharacters().size() == 0){
            Character.people[4].loadCharacters(getActivity(),4);
        }

        if(savedInstanceState != null) {
            factionID = savedInstanceState.getLong("factionID");
        }

        return inflater.inflate(R.layout.fragment_character_detail, container, false);
    }

    @Override
    public void onSaveInstanceState(Bundle savedInstanceState){

        savedInstanceState.putLong("factionID", factionID);
    }

    interface ButtonClickListener{

        void addCharacterClicked(View view);
    }

    @Override
    public void onAttach(Context context){
        super.onAttach(context);
        listener = (ButtonClickListener)context;
    }

    @Override
    public void onClick(View view){
        if(listener != null){
            listener.addCharacterClicked(view);
        }
    }

    public void addCharacter(){

        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Character");
        dialog.setCancelable(true);

        final EditText editText = (EditText) dialog.findViewById(R.id.addCharacter);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                String characterName = editText.getText().toString();
                Character.people[(int)factionID].getCharacters().add(characterName);
                CharacterDetailFragment.this.adapter.notifyDataSetChanged();
                Character.people[(int)factionID].storeCharacters(getActivity(), factionID);
                dialog.dismiss();
            }
        });

        dialog.show();
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){

        super.onCreateContextMenu(menu, view, menuInfo);

        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String characterName = adapter.getItem(adapterContextMenuInfo.position);

        menu.setHeaderTitle("Delete " + characterName);
        menu.add(1,1,1,"Yes");
        menu.add(2,2,2,"No");
    }

    @Override
    public boolean onContextItemSelected(MenuItem item){

        int itemID = item.getItemId();

        if(itemID == 1){
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();

            Character.people[(int)factionID].getCharacters().remove(info.position);
            CharacterDetailFragment.this.adapter.notifyDataSetChanged();
            Character.people[(int)factionID].storeCharacters(getActivity(), factionID);

        }

        return true;
    }

}
