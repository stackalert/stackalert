package io.stackalert.android;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;

import com.basecamp.turbolinks.TurbolinksSession;
import com.basecamp.turbolinks.TurbolinksAdapter;
import com.basecamp.turbolinks.TurbolinksView;

public class MainActivity extends AppCompatActivity implements TurbolinksAdapter {

    private static final String BASE_URL = "http://172.18.0.1:3000";
    private static final String INTENT_URL = "sign-in";

    private String location;
    private TurbolinksView turbolinksView;

    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
            = new BottomNavigationView.OnNavigationItemSelectedListener() {

        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            System.out.println("hello");
            TurbolinksView turbolinksView = (TurbolinksView) findViewById(R.id.turbolinks_view);
            TurbolinksSession.getDefault(MainActivity.this).setDebugLoggingEnabled(true);
            location = getIntent().getStringExtra(INTENT_URL) != null ? getIntent().getStringExtra(INTENT_URL) : BASE_URL;
            System.out.println(MainActivity.this.turbolinksView);
            switch (item.getItemId()) {
                case R.id.navigation_home:
                    TurbolinksSession.getDefault(MainActivity.this)
                            .activity(MainActivity.this)
                            .adapter(MainActivity.this)
                            .view(turbolinksView)
                            .visit(location);
                    return true;
                case R.id.navigation_dashboard:
                    TurbolinksSession.getDefault(MainActivity.this)
                            .activity(MainActivity.this)
                            .adapter(MainActivity.this)
                            .view(turbolinksView)
                            .visit(location);
                    return true;
                case R.id.navigation_notifications:
                    TurbolinksSession.getDefault(MainActivity.this)
                            .activity(MainActivity.this)
                            .adapter(MainActivity.this)
                            .view(turbolinksView)
                            .visit(location);
                    return true;
            }
            return false;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        BottomNavigationView navigation = (BottomNavigationView) findViewById(R.id.navigation);
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);

        TurbolinksView turbolinksView = (TurbolinksView) findViewById(R.id.turbolinks_view);
        TurbolinksSession.getDefault(this).setDebugLoggingEnabled(true);

        location = getIntent().getStringExtra(INTENT_URL) != null ? getIntent().getStringExtra(INTENT_URL) : BASE_URL;
        System.out.println("hello2");
        TurbolinksSession.getDefault(this)
                .activity(this)
                .adapter(this)
                .view(turbolinksView)
                .visit(location);
    }

    @Override
    protected void onRestart() {
        super.onRestart();

        // Since the webView is shared between activities, we need to tell Turbolinks
        // to load the location from the previous activity upon restarting
        TurbolinksSession.getDefault(this)
                .activity(this)
                .adapter(this)
                .restoreWithCachedSnapshot(true)
                .view(turbolinksView)
                .visit(location);
    }

    @Override
    public void onPageFinished() {

    }

    @Override
    public void onReceivedError(int errorCode) {
        System.out.println(errorCode);
        handleError(errorCode);
    }

    @Override
    public void pageInvalidated() {

    }

    @Override
    public void requestFailedWithStatusCode(int statusCode) {
        handleError(statusCode);
    }

    @Override
    public void visitCompleted() {

    }

    @Override
    public void visitProposedToLocationWithAction(String location, String action) {
        Intent intent = new Intent(this, MainActivity.class);
        intent.putExtra(INTENT_URL, location);

        this.startActivity(intent);
    }

    private void handleError(int code) {
        if (code == 404) {
            TurbolinksSession.getDefault(this)
                    .activity(this)
                    .adapter(this)
                    .restoreWithCachedSnapshot(false)
                    .view(turbolinksView)
                    .visit(BASE_URL + "/error");
        }
    }

}
