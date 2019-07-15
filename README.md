# flutter biometric_auth

Fingerprint authentication flutter

![20190715_204624](https://user-images.githubusercontent.com/43071332/61228205-70492500-a743-11e9-9b04-b8ee775dd716.gif)


## Getting Started

Note:- If you are using latest version of local_auth then you have to migrate android x. 
visit : https://flutter.dev/docs/development/packages-and-plugins/androidx-compatibility

Note: If you are getting this error- [  no fragmentactivity, local auth plugin requires activity to be a FragmentActivity., null ]
then follow these steps:- 

In MainActivity.java replace existing codes with these codes:

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.app.FlutterFragmentActivity;

public class MainActivity extends FlutterFragmentActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }
}


