package flutter.plugins.screen.screen;

import android.app.Activity;
import android.content.Context;
import android.provider.Settings;
import android.view.WindowManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;

/**
 * ScreenPlugin
 */
public class ScreenPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context applicationContext;
    private Activity activity;

    // --- FlutterPlugin

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        channel = new MethodChannel(binding.getBinaryMessenger(), "github.com/clovisnicolas/flutter_screen");
        channel.setMethodCallHandler(this);
        applicationContext = binding.getApplicationContext();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        channel = null;
        applicationContext = null;
    }

    // --- ActivityAware

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        activity = null;
    }

    // --- MethodCallHandler

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "brightness":
                result.success(getBrightness());
                break;
            case "setBrightness":
                double brightness = call.argument("brightness");
                WindowManager.LayoutParams layoutParams = activity.getWindow().getAttributes();
                layoutParams.screenBrightness = (float) brightness;
                activity.getWindow().setAttributes(layoutParams);
                result.success(null);
                break;
            case "isKeptOn":
                int flags = activity.getWindow().getAttributes().flags;
                result.success((flags & WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON) != 0);
                break;
            case "keepOn":
                boolean on = call.argument("on");
                if (on) {
                    System.out.println("Keeping screen on ");
                    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
                } else {
                    System.out.println("Not keeping screen on");
                    activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
                }
                result.success(null);
                break;

            default:
                result.notImplemented();
                break;
        }
    }

    private float getBrightness() {
        float result = activity.getWindow().getAttributes().screenBrightness;
        if (result < 0) { // the application is using the system brightness
            try {
                result = Settings.System.getInt(applicationContext.getContentResolver(), Settings.System.SCREEN_BRIGHTNESS) / (float) 255;
            } catch (Settings.SettingNotFoundException e) {
                result = 1.0f;
                e.printStackTrace();
            }
        }
        return result;
    }
}
