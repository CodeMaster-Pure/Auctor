import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
	FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
	
	override func applicationDidEnterBackground(_ application: UIApplication) {
        self.window.isHidden = true
    }
	
	override func applicationWillEnterForeground(_ application: UIApplication) {
        self.window.isHidden = false
    }
}
