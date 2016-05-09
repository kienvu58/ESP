package com.nhom1.esp.esppart3;

import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class EDDActivity extends AppCompatActivity {
    ToggleButton power;
    RadioButton switch1;
    RadioButton switch2;
    ArrayList<ToggleButton> lightList = new ArrayList<>();
    ArrayList<EditText> CList = new ArrayList<>();
    ArrayList<EditText> DList = new ArrayList<>();
    TextView timeTV;

    public static final int MAX = 1000;
    int[] id;
    int[] C;
    int[] D;
    int[] nSchedules;         // number of elements in schedule array
    int[] schedule123;      // contain the schedule for 1, 2, 3
    int[] schedule45;       // contain the schedule for 4, 5
    int[] schedule6789;     // contain the schedule for 6, 7, 8, 9
    int isSchedulable123, isSchedulable45, isSchedulable6789;
    InputStreamReader inputFileTask;    // input stream to read initial information

    String alert;    // message to display when tasks is not schedulable
    int updateFreq = 1000;
    int time;
    Handler handler;
    Thread updateThread;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edd);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        getView();
        try {
            initializeTaskInformation();
        } catch (IOException e) {
            e.printStackTrace();
        }

        prepareThread();

        disableAllLight();
        switch1.setEnabled(false);
        switch2.setEnabled(false);
        power.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    time = 0;
                    computeSchedule();
                    alert();
                    enableAllLight();
                    disableLight6789();
                    switch1.setEnabled(true);
                    switch2.setEnabled(true);
                } else {
                    disableAllLight();
                    switch1.setChecked(true);
                    switch2.setChecked(false);
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
        timeTV = (TextView) findViewById(R.id.time);

        for (int i = 0; i < 9; i++) {
            String name = "light" + i;
            int id = getResources().getIdentifier(name, "id", getPackageName());
            lightList.add((ToggleButton) findViewById(id));
        }

        for (int i = 0; i < 9; i++) {
            String name = "C" + i;
            int id = getResources().getIdentifier(name, "id", getPackageName());
            CList.add((EditText) findViewById(id));
        }

        for (int i = 0; i < 9; i++) {
            String name = "D" + i;
            int id = getResources().getIdentifier(name, "id", getPackageName());
            DList.add((EditText) findViewById(id));
        }
    }

    private void prepareThread() {
        handler = new Handler();
        updateThread = new Thread() {
            public void run() {
                try {
                    while (true) { // infinite loop to update app changes
                        handler.post(new Runnable() {
                            public void run() {
                                if (power.isChecked()) {
                                    updateLight();
                                    updateTime();
                                }
                            }
                        });
                        sleep(updateFreq);
                    }
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        };
        updateThread.start();
    }

    private void updateTime() {
        timeTV.setText("Thời gian " + String.valueOf(time) + "s");
        time++;
    }

    private void updateLight() {
        if (switch1.isChecked()) {
            // if schedulable then turn off previous light and turn on current light
            if (isSchedulable123 == 1) {
                if (time > 0) {
                    turnOffLight(schedule123[time - 1] - 1);
                }
                turnOnLight(schedule123[time] - 1);
            }
            if (isSchedulable45 == 1) {
                if (time > 0) {
                    turnOffLight(schedule45[time - 1] - 1);
                }
                turnOnLight(schedule45[time] - 1);
            }
        } else { // switch2 is checked
            if (isSchedulable6789 == 1) {
                if (time > 0) {
                    turnOffLight(schedule123[time - 1] - 1);
                }
                turnOnLight(schedule6789[time] - 1);
            }
            if (isSchedulable45 == 1) {
                if (time > 0) {
                    turnOffLight(schedule45[time - 1] - 1);
                }
                turnOnLight(schedule45[time] - 1);
            }
        }
    }

    private void alert() {
        alert = "";
        if (isSchedulable123 == 0) alert += "Các nhà 1, 2, 3 không lập lịch được.\n";
        if (isSchedulable45 == 0) alert += "Các nhà 4, 5 không lập lịch được.\n";
        if (isSchedulable6789 == 0) alert += "Các nhà 6, 7, 8, 9 không lập lịch được.\n";
        if (!alert.isEmpty()) {
            Toast.makeText(getApplicationContext(), alert, Toast.LENGTH_LONG).show();
        }
    }

    private void computeSchedule() {
        schedule123 = new int[MAX];
        schedule45 = new int[MAX];
        schedule6789 = new int[MAX];

        C = new int[9];
        D = new int[9];
        nSchedules = new int[9];    // number of elements is not important

        id = new int[]{1, 2, 3};
        getTaskInformation(id, 3);
        isSchedulable123 = eddScheduleJNI(id, C, D, 3, schedule123, nSchedules);

        id = new int[]{4, 5};
        getTaskInformation(id, 2);
        isSchedulable45 = eddScheduleJNI(id, C, D, 2, schedule45, nSchedules);

        id = new int[]{6, 7, 8, 9};
        getTaskInformation(id, 4);
        isSchedulable6789 = eddScheduleJNI(id, C, D, 4, schedule6789, nSchedules);
    }

    private void getTaskInformation(int[] id, int nIds) {
        for (int i = 0; i < nIds; i++) {
            C[i] = Integer.valueOf(CList.get(id[i] - 1).getText().toString());
            D[i] = Integer.valueOf(DList.get(id[i] - 1).getText().toString());
        }
    }

    private void initializeTaskInformation() throws IOException {
        try {
            inputFileTask = new InputStreamReader(getResources().openRawResource(R.raw.task));
            BufferedReader br = new BufferedReader(inputFileTask);

            int i = 0;
            String line;
            while ((line = br.readLine()) != null && i < 9) {
                String a[] = line.split(" ");
                CList.get(i).setText(String.valueOf(a[0]));
                DList.get(i).setText(String.valueOf(a[1]));
                i++;
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (inputFileTask != null) {
                inputFileTask.close();
            }
        }
    }

    private void turnOffLight(int id) {
        if (id < 0 || id > 8) return;
        lightList.get(id).setChecked(false);
    }

    private void turnOnLight(int id) {
        if (id < 0 || id > 8) return;
        lightList.get(id).setChecked(true);
    }


    private void disableAllLight() {
        for (ToggleButton light : lightList) {
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
        for (ToggleButton light : lightList) {
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

        /* native method */
    public native int eddScheduleJNI(int id[], int C[], int D[], int nTasks, int result[], int nResults[]);

    static {
        System.loadLibrary("esp-jni");
    }
}
