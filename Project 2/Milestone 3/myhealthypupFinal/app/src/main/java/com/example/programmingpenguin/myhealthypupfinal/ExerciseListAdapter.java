package com.example.programmingpenguin.myhealthypupfinal;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import org.w3c.dom.Text;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;

/**
 * Created by ProgrammingPenguin on 4/16/17.
 */

public class ExerciseListAdapter extends ArrayAdapter<ExerciseData> {

    private static final String TAG = "ExerciseListAdapter";
    private Context mContext;
    private int mResource;

    public ExerciseListAdapter(@NonNull Context context, int resource, ArrayList<ExerciseData> objects) {
        super(context, resource, objects);
        mContext = context;
        mResource = resource;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        String date = getItem(position).getDate();
        String time = getItem(position).getTime();
        String length = getItem(position).getLength();
        String place = getItem(position).getPlace();

        ExerciseData exercise = new ExerciseData(date, time, length, place);

        LayoutInflater inflater = LayoutInflater.from(mContext);
        convertView = inflater.inflate(mResource, parent, false);

        TextView textDate = (TextView) convertView.findViewById(R.id.date_view);
        TextView textTime = (TextView) convertView.findViewById(R.id.time_view);
        TextView textLength = (TextView) convertView.findViewById(R.id.length_view);
        TextView textPlace = (TextView) convertView.findViewById(R.id.place_view);

        textDate.setText(date);
        textTime.setText(time);
        textLength.setText(length);
        textPlace.setText(place);

        return convertView;

    }


}
