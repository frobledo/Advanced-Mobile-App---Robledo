package com.example.programmingpenguin.myhealthypupfinal;

import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

/**
 * Created by ProgrammingPenguin on 4/15/17.
 */

//As of now, I am able to write information to Firebase, but I have not been able to incorporate retrieving the information (Project 3 milestone)

public class Info extends Fragment {

    InfoData myInfo = new InfoData("Name", "Age", "Breed", "Vet Name", "Vet Phone Number");

    public Info() {
        // Required empty public constructor
    }

    @Override
    public void onStart() {

        super.onStart();

        View view = getView();

        TextView name = (TextView) view.findViewById(R.id.pup_name);
        name.setText(myInfo.getName());

        TextView age = (TextView) view.findViewById(R.id.age);
        age.setText(myInfo.getAge());

        TextView breed = (TextView) view.findViewById(R.id.breed);
        breed.setText(myInfo.getBreed());

        TextView vet_name = (TextView) view.findViewById(R.id.name_vet);
        vet_name.setText(myInfo.getVet_name());

        TextView phone = (TextView) view.findViewById(R.id.phone);
        phone.setText(myInfo.getVet_phone());

        Button addNameButton = (Button) view.findViewById(R.id.add_name);
        View.OnClickListener onclick = new View.OnClickListener(){
            public void onClick(View view){

                addName(view);

            }
        };
        addNameButton.setOnClickListener(onclick);


        Button addAgeButton = (Button) view.findViewById(R.id.add_age);
        View.OnClickListener onclick1 = new View.OnClickListener(){
            public void onClick(View view){

                addAge(view);
            }
        };
        addAgeButton.setOnClickListener(onclick1);


        Button addBreedButton = (Button) view.findViewById(R.id.add_breed);
        View.OnClickListener onclick2 = new View.OnClickListener(){
            public void onClick(View view){

                addBreed(view);
            }
        };
        addBreedButton.setOnClickListener(onclick2);


        Button addVetInfoButton = (Button) view.findViewById(R.id.add_vet_info);
        View.OnClickListener onclick3 = new View.OnClickListener(){
            public void onClick(View view){

                addVetInfo(view);
            }
        };
        addVetInfoButton.setOnClickListener(onclick3);

    }

    @Override
    public void onSaveInstanceState(Bundle savedInstanceState){
        savedInstanceState.putString("name", myInfo.getName());
        savedInstanceState.putString("age", myInfo.getAge());
        savedInstanceState.putString("breed", myInfo.getBreed());
        savedInstanceState.putString("vet_name", myInfo.getVet_name());
        savedInstanceState.putString("phone", myInfo.getVet_phone());
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, Bundle savedInstanceState) {

        if(savedInstanceState != null){

            String name = savedInstanceState.getString("name", myInfo.getName());
            myInfo.setName(name);

            String age = savedInstanceState.getString("age", myInfo.getAge());
            myInfo.setAge(age);

            String breed = savedInstanceState.getString("breed", myInfo.getBreed());
            myInfo.setBreed(breed);

            String vet_name = savedInstanceState.getString("vet_name", myInfo.getVet_name());
            myInfo.setVet_name(vet_name);

            String phone = savedInstanceState.getString("phone", myInfo.getVet_phone());
            myInfo.setVet_phone(phone);

        }

        return inflater.inflate(R.layout.info_tab, container, false);
    }

    public void addName(View view) {

        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.add_profile);
        dialog.setCancelable(true);

        final EditText add_info = (EditText) dialog.findViewById(R.id.edit_name);


        Button button = (Button) dialog.findViewById(R.id.save_name);
        button.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                String new_name = add_info.getText().toString();
                myInfo.setName(new_name);

                FirebaseDatabase database = FirebaseDatabase.getInstance();
                DatabaseReference myRef = database.getReference("Pet Name");
                myRef.setValue(new_name);

                dialog.dismiss();
                onDismiss(dialog);
            }
        });

        dialog.show();
    }

    public void addAge(View view) {

        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.add_age);
        dialog.setCancelable(true);

        final EditText add_info = (EditText) dialog.findViewById(R.id.edit_age);

        Button button = (Button) dialog.findViewById(R.id.save_age);
        button.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                String new_age = add_info.getText().toString();
                myInfo.setAge(new_age);

                FirebaseDatabase database = FirebaseDatabase.getInstance();
                DatabaseReference myRef = database.getReference("Pet age");
                myRef.setValue(new_age);

                dialog.dismiss();
                onDismiss(dialog);

            }
        });

        dialog.show();
    }

    public void addBreed(View view) {

        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.add_breed);
        dialog.setCancelable(true);

        final EditText add_info = (EditText) dialog.findViewById(R.id.edit_breed);

        Button button = (Button) dialog.findViewById(R.id.save_breed);
        button.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                String new_breed = add_info.getText().toString();
                myInfo.setBreed(new_breed);

                FirebaseDatabase database = FirebaseDatabase.getInstance();
                DatabaseReference myRef = database.getReference("Pet Breed");
                myRef.setValue(new_breed);

                dialog.dismiss();
                onDismiss(dialog);

            }
        });

        dialog.show();
    }

    public void addVetInfo(View view) {

        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.add_vet_info);
        dialog.setCancelable(true);

        final EditText add_name = (EditText) dialog.findViewById(R.id.edit_vet_name);
        final EditText add_phone = (EditText) dialog.findViewById(R.id.edit_vet_number);

        Button button = (Button) dialog.findViewById(R.id.save_vet);
        button.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                String new_name = add_name.getText().toString();
                myInfo.setVet_name(new_name);

                String new_phone = add_phone.getText().toString();
                myInfo.setVet_phone(new_phone);


                FirebaseDatabase database = FirebaseDatabase.getInstance();
                DatabaseReference myRefVet = database.getReference("Pet Vet");
                myRefVet.setValue(new_name);

                DatabaseReference myRefVetPhone = database.getReference("Pet Vet Phone");
                myRefVetPhone.setValue(new_phone);

                dialog.dismiss();
                onDismiss(dialog);

            }
        });

        dialog.show();
    }

    void onDismiss(DialogInterface dialog){

        View view = getView();

        TextView name = (TextView) view.findViewById(R.id.pup_name);
        name.setText(myInfo.getName());

        TextView age = (TextView) view.findViewById(R.id.age);
        age.setText(myInfo.getAge());

        TextView breed = (TextView) view.findViewById(R.id.breed);
        breed.setText(myInfo.getBreed());

        TextView vet_name = (TextView) view.findViewById(R.id.name_vet);
        vet_name.setText(myInfo.getVet_name());

        TextView phone = (TextView) view.findViewById(R.id.phone);
        phone.setText(myInfo.getVet_phone());

    }

}
