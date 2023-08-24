// Swift
import Flutter
import UIKit
import CoreBluetooth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "bluetooth_control"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let bluetoothChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
        bluetoothChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "enableBluetooth" {
                self?.showBluetoothDialog(result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func showBluetoothDialog(result: @escaping FlutterResult) {
        let alertController = UIAlertController(
            title: "Enable Bluetooth",
            message: "Please enable Bluetooth in the Settings app to continue.",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            result(true)
        })
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        controller.present(alertController, animated: true, completion: nil)
    }
}
