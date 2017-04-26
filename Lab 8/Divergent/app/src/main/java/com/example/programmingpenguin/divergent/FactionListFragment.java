package com.example.programmingpenguin.divergent;


import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;


/**
 * A simple {@link Fragment} subclass.
 */
public class FactionListFragment extends Fragment implements AdapterView.OnItemClickListener {

    private FactionListListener listener;

    public FactionListFragment() {
        // Required empty public constructor
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();

        if(view != null){
            ListView listFactions = (ListView)view.findViewById(R.id.listView);
            ArrayAdapter<Character>listAdapter= new ArrayAdapter<Character>(getActivity(), android.R.layout.simple_list_item_1, Character.people);
            listFactions.setAdapter(listAdapter);
            listFactions.setOnItemClickListener(this);
        }

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_faction_list, container, false);
    }

    interface FactionListListener{
        void itemClicked(long id);
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        listener = (FactionListListener) context;
    }

    @Override
    public void onItemClick(AdapterView<?>parent, View view, int position, long id){

        if(listener != null){
            listener.itemClicked(id);
        }
    }


}
