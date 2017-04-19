package com.example.programmingpenguin.myhealthypupfinal;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by ProgrammingPenguin on 4/16/17.
 */

public class HealthDietListAdapter extends ArrayAdapter<HealthDietData> {

    private static final String TAG = "HealthDietListAdapter";
    private Context mContext;
    private int mResource;

    public HealthDietListAdapter(@NonNull Context context, int resource, ArrayList<HealthDietData> objects) {
        super(context, resource, objects);
        mContext = context;
        mResource = resource;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        String date = getItem(position).getDate();
        String type = getItem(position).getType();
        String notes = getItem(position).getNotes();

        HealthDietData data = new HealthDietData(date, type, notes);

        LayoutInflater inflater = LayoutInflater.from(mContext);
        convertView = inflater.inflate(mResource, parent, false);

        TextView textDate = (TextView) convertView.findViewById(R.id.date_view);
        TextView textType = (TextView) convertView.findViewById(R.id.type_view);
        TextView textNotes = (TextView) convertView.findViewById(R.id.notes_view);

        textDate.setText(date);
        textType.setText(type);
        textNotes.setText(notes);

        return convertView;

    }


}
