#import "ScreenPlugin.h"

@implementation ScreenPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"github.com/clovisnicolas/flutter_screen"
            binaryMessenger:[registrar messenger]];
  ScreenPlugin* instance = [[ScreenPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"brightness" isEqualToString:call.method]) {
    result([NSNumber numberWithFloat:[UIScreen mainScreen].brightness]);
  }
  else if ([@"setBrightness" isEqualToString:call.method]) {
    NSNumber *brightness = call.arguments[@"brightness"];
    [[UIScreen mainScreen] setBrightness:brightness.floatValue];
    result(nil);
  }
  else if ([@"isKeptOn" isEqualToString:call.method]) {
    bool isIdleTimerDisabled =  [[UIApplication sharedApplication] isIdleTimerDisabled];
    result([NSNumber numberWithBool:isIdleTimerDisabled]);
  }
  else if ([@"keepOn" isEqualToString:call.method]) {
    NSNumber *b = call.arguments[@"on"];
    [[UIApplication sharedApplication] setIdleTimerDisabled:b.boolValue];
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
