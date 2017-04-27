package com.example.programmingpenguin.mybooks;

import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.ContextMenu;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class BooksMainActivity extends AppCompatActivity {

    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference();

    List books = new ArrayList<>();
    ArrayAdapter<BookItem> listAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_books_main);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                final Dialog dialog = new Dialog(BooksMainActivity.this);
                dialog.setContentView(R.layout.dialog);
                dialog.setTitle("Add Book");
                dialog.setCancelable(true);

                final EditText nameEditText = (EditText)dialog.findViewById(R.id.editTextName);
                final EditText urlEditText = (EditText)dialog.findViewById(R.id.editTextURL);

                Button button = (Button)dialog.findViewById(R.id.addButton);
                button.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {

                        String bookName = nameEditText.getText().toString();
                        String bookURL = urlEditText.getText().toString();

                        if(bookName.trim().length()>0){
                            BookItem newBook = new BookItem(bookName, bookURL);
                            books.add(newBook);
                            listAdapter.notifyDataSetChanged();
                            ref.child(bookName).setValue(newBook);
                            dialog.dismiss();
                        } else{

                            Context context = getApplicationContext();
                            CharSequence text = getString(R.string.add_book_toast);
                            int duration = Toast.LENGTH_SHORT;

                            Toast toast = Toast.makeText(context, text, duration);
                            toast.show();
                        }
                    }
                });

                dialog.show();

            }
        });

        final ListView bookList = (ListView)findViewById(R.id.listView);
        listAdapter = new ArrayAdapter<BookItem>(this, android.R.layout.simple_list_item_1, books);
        bookList.setAdapter(listAdapter);

        ValueEventListener firebaseListener = new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {

                books.clear();

                for(DataSnapshot snapshot :  dataSnapshot.getChildren()) {
                    BookItem newBook = snapshot.getValue(BookItem.class);
                    books.add(newBook);
                    Log.d("data", "Value is: " + newBook.getName() + newBook.getUrl());
                }

                listAdapter.notifyDataSetChanged();
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

                Log.w("oncreate", "Failed to read value.", databaseError.toException());
            }
        };

        ref.addValueEventListener(firebaseListener);
        registerForContextMenu(bookList);

        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {

                BookItem bookTapped = (BookItem)books.get(position);
                String bookURL = bookTapped.getUrl();

                Intent intent = new Intent(Intent.ACTION_VIEW);
                intent.setData(Uri.parse(bookURL));
                startActivity(intent);

            }
        };

        bookList.setOnItemClickListener(itemClickListener);

    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){

        super.onCreateContextMenu(menu, view, menuInfo);

        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String bookname = ((TextView)adapterContextMenuInfo.targetView).getText().toString();

        menu.setHeaderTitle("Delete" + bookname);
        menu.add(1,1,1,"Yes");
        menu.add(2,2,2, "No");
    }

    @Override
    public boolean onContextItemSelected(MenuItem item){

        int itemId = item.getItemId();
        if(itemId == 1){

            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo)item.getMenuInfo();
            String bookname = ((TextView)info.targetView).getText().toString();
            books.remove(info.position);
            listAdapter.notifyDataSetChanged();
            ref.child(bookname).removeValue();
        }

        return true;

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_books_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
