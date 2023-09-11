import UIKit
import Flutter
import FirebaseCore
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyBbeqHE0gEJuJz7wz3hoiUw-MT3FSiQ9wE")

    GeneratedPluginRegistrant.register(with: self)
   
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
  }
}
