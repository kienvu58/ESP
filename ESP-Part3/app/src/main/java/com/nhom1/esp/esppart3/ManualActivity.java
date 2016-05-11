package com.nhom1.esp.esppart3;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.widget.CompoundButton;
import android.widget.RadioButton;
import android.widget.Toast;
import android.widget.ToggleButton;

import java.util.ArrayList;

public class ManualActivity extends AppCompatActivity {
    ToggleButton power;
    RadioButton switch1;
    RadioButton switch2;
    ArrayList<ToggleButton> lightList = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_manual);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        getView();
        disableAllLight();
        switch1.setEnabled(false);
        switch2.setEnabled(false);
        power.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    enableAllLight();
                    disableLight6789();
                    switch1.setChecked(true);
                    switch1.setEnabled(true);
                    switch2.setEnabled(true);
                } else {
                    disableAllLight();
                    switch1.setEnabled(false);
                    switch2.setEnabled(false);
                }
            }
        });
        switch1.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    Toast.makeText(getApplicationContext(), "Chuyển Công tắc 1", Toast.LENGTH_SHORT).show();
                    enableLight123();
                    disableLight6789();
                }
            }
        });
        switch2.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    Toast.makeText(getApplicationContext(), "Chuyển Công tắc 2", Toast.LENGTH_SHORT).show();
                    enableLight6789();
                    disableLight123();
                }
            }
        });
    }

    private void getView() {
        power = (ToggleButton) findViewById(R.id.power);
        switch1 = (RadioButton) findViewById(R.id.switch1);
        switch2 = (RadioButton) findViewById(R.id.switch2);

        for (int i = 0; i < 9; i++) {
            String name = "light" + i;
            int id = getResources().getIdentifier(name, "id", getPackageName());
            lightList.add((ToggleButton) findViewById(id));
        }
    }

    private void disableAllLight() {
        for (ToggleButton light: lightList) {
            light.setChecked(false);
            light.setEnabled(false);
        }
    }

    private void disableLight123() {
        for (int i = 0; i < 3; i++) {
            lightList.get(i).setChecked(false);
            lightList.get(i).setEnabled(false);
        }
    }

    private void disableLight6789() {
        for (int i = 5; i < 9; i++) {
            lightList.get(i).setChecked(false);
            lightList.get(i).setEnabled(false);
        }
    }

    private void enableAllLight() {
        for (ToggleButton light: lightList) {
            light.setEnabled(true);
        }
    }

    private void enableLight123() {
        for (int i = 0; i < 3; i++) {
            lightList.get(i).setEnabled(true);
        }
    }

    private void enableLight6789() {
        for (int i = 5; i < 9; i++) {
            lightList.get(i).setEnabled(true);
        }
    }
}
