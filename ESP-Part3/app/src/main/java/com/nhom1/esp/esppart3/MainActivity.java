package com.nhom1.esp.esppart3;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }
    public  void manual (View view){
        Intent intent = new Intent(this,ManualActivity.class);
        startActivity(intent);
    }
    public void edd(View view ){
        Intent intent = new Intent(this,EDDActivity.class);
        startActivity(intent);
    }
    public void rm(View view ){
        Intent intent = new Intent(this,RMActivity.class);
        startActivity(intent);
    }
}
