package flutter.plugins.screen.screen;

import android.provider.Settings;
import android.view.WindowManager;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * ScreenPlugin
 */
public class ScreenPlugin implements MethodCallHandler {

  private ScreenPlugin(Registrar registrar){
    this._registrar = registrar;
  }
  private Registrar _registrar;

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "github.com/clovisnicolas/flutter_screen");
    channel.setMethodCallHandler(new ScreenPlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch(call.method){
      case "brightness":
        result.success(getBrightness());
        break;
      case "setBrightness":
        double brightness = call.argument("brightness");
        WindowManager.LayoutParams layoutParams = _registrar.activity().getWindow().getAttributes();
        layoutParams.screenBrightness = (float)brightness;
        _registrar.activity().getWindow().setAttributes(layoutParams);
        result.success(null);
        break;
      case "resetBrightness":
        WindowManager.LayoutParams params = _registrar.activity().getWindow().getAttributes();
        params.screenBrightness = WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE;
        _registrar.activity().getWindow().setAttributes(params);
        result.success(null);
        break;
      case "isKeptOn":
        int flags = _registrar.activity().getWindow().getAttributes().flags;
        result.success((flags & WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON) != 0) ;
        break;
      case "keepOn":
        Boolean on = call.argument("on");
        if (on) {
          System.out.println("Keeping screen on ");
          _registrar.activity().getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        }
        else{
          System.out.println("Not keeping screen on");
          _registrar.activity().getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        }
        result.success(null);
        break;

      default:
        result.notImplemented();
        break;
    }
  }

  private float getBrightness(){
    float result = _registrar.activity().getWindow().getAttributes().screenBrightness;
    if (result < 0) { // the application is using the system brightness
      try {
        result = Settings.System.getInt(_registrar.context().getContentResolver(), Settings.System.SCREEN_BRIGHTNESS) / (float)255;
      } catch (Settings.SettingNotFoundException e) {
        result = 1.0f;
        e.printStackTrace();
      }
    }
    return result;
  }

}
