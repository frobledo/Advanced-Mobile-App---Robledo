package com.example.programmingpenguin.robledofinal;


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
public class SettingListFragment extends Fragment implements AdapterView.OnItemClickListener{

    private SettingListListener listener;

    public SettingListFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_setting_list, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();

        if (view != null){
            ListView listSetting = (ListView) view.findViewById(R.id.listView);
            ArrayAdapter<Exercise> listAdapter = new ArrayAdapter<Exercise>(getActivity(), android.R.layout.simple_list_item_1, Exercise.work);
            listSetting.setAdapter(listAdapter);
            listSetting.setOnItemClickListener(this);
        }

    }

    interface SettingListListener {
        void itemClicked(long id);
    }

    @Override
    public void onAttach(Context context){
        super.onAttach(context);
        listener = (SettingListListener)context;
    }

    @Override public void onItemClick(AdapterView<?>parent, View view, int position, long id){
        if(listener != null){
            listener.itemClicked(id);
        }
    }

}
