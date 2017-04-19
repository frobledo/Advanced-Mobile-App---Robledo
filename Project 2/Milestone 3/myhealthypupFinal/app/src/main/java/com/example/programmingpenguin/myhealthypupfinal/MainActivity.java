/*
Resources for project:
Relied heavily on Android documentation to implement most methods
App icon: created in Illustrator
To set up tablayout and viewpager: https://www.youtube.com/watch?v=ZnhSbXuJaqQ
Icons for tabs retrieved from: https://icons8.com/web-app/category/all/Science
To set up columns in listview: https://www.youtube.com/watch?v=E6vE8fqQPTE
Store values when device is rotated: http://stackoverflow.com/questions/17183432/how-to-store-values-in-onsaveinstancestate-and-retrive
onDismiss method: http://stackoverflow.com/questions/9853430/refresh-fragment-when-dialogfragment-is-dismissed

Limitations:
1. The delete functions works for the items in the Health tab but not for the Exercise and Diet tab
2. The information from the info tab is linked to Firebase and writes to the database, but the information cannot be retrieved at this moment
3. No current data persistence -- will be added as part of Project 3
4. The charts for the Exercise tab will not be developed for this iteration

*/
package com.example.programmingpenguin.myhealthypupfinal;

import android.support.design.widget.TabLayout;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class MainActivity extends AppCompatActivity {

    /**
     * The {@link android.support.v4.view.PagerAdapter} that will provide
     * fragments for each of the sections. We use a
     * {@link FragmentPagerAdapter} derivative, which will keep every
     * loaded fragment in memory. If this becomes too memory intensive, it
     * may be best to switch to a
     * {@link android.support.v4.app.FragmentStatePagerAdapter}.
     */
    private SectionsPagerAdapter mSectionsPagerAdapter;

    /**
     * The {@link ViewPager} that will host the section contents.
     */
    private ViewPager mViewPager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        // Create the adapter that will return a fragment for each of the three
        // primary sections of the activity.
        mSectionsPagerAdapter = new SectionsPagerAdapter(getSupportFragmentManager());

        // Set up the ViewPager with the sections adapter.
        mViewPager = (ViewPager) findViewById(R.id.container);
        mViewPager.setAdapter(mSectionsPagerAdapter);

        final int[] ICONS = new int[]{
                R.drawable.health,
                R.drawable.exercise,
                R.drawable.diet,
                R.drawable.profile
        };


        TabLayout tabLayout = (TabLayout) findViewById(R.id.tabs);
        tabLayout.setupWithViewPager(mViewPager);

        tabLayout.getTabAt(0).setIcon(ICONS[0]);
        tabLayout.getTabAt(1).setIcon(ICONS[1]);
        tabLayout.getTabAt(2).setIcon(ICONS[2]);
        tabLayout.getTabAt(3).setIcon(ICONS[3]);
    }


    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {
        /**
         * The fragment argument representing the section number for this
         * fragment.
         */
        private static final String ARG_SECTION_NUMBER = "section_number";

        public PlaceholderFragment() {
        }

        /**
         * Returns a new instance of this fragment for the given section
         * number.
         */
        public static PlaceholderFragment newInstance(int sectionNumber) {
            PlaceholderFragment fragment = new PlaceholderFragment();
            Bundle args = new Bundle();
            args.putInt(ARG_SECTION_NUMBER, sectionNumber);
            fragment.setArguments(args);
            return fragment;
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                                 Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main, container, false);

            return rootView;
        }
    }

    /**
     * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
     * one of the sections/tabs/pages.
     */
    public class SectionsPagerAdapter extends FragmentPagerAdapter {

        public SectionsPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {

            switch(position){

                case 0:
                    Health health = new Health();
                    return health;

                case 1:
                    Exercise exercise = new Exercise();
                    return exercise;

                case 2:
                    Diet diet = new Diet();
                    return diet;

                case 3:
                    Info info = new Info();
                    return info;
            }

            return null;
        }

        @Override
        public int getCount() {
            // Show 3 total pages.
            return 4;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            switch (position) {
                case 0:
                    return "Health";
                case 1:
                    return "Exercise";
                case 2:
                    return "Diet";
                case 3:
                    return "Info";
            }
            return null;
        }
    }

}
