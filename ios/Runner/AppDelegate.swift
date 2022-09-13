import Flutter
import KakaoSDKAuth
import NaverThirdPartyLogin
import UIKit
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var locationManager = CLLocationManager()

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if (CLLocationManager.locationServicesEnabled()) {
            switch CLLocationManager.authorizationStatus() {
            case .denied, .notDetermined, .restricted:
                self.locationManager.requestAlwaysAuthorization()
                break
            default:
                break
            }
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if url.absoluteString.hasPrefix("kakao") { // if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        return NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
    }
}
