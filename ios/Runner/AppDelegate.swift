import Flutter
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
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
        KakaoSDK.initSDK(appKey: "${8358269776945a3b1fdedf8a7f09c6da}")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
//         if url.absoluteString.hasPrefix("kakao") { // if AuthApi.isKakaoTalkLoginUrl(url) {
//             return AuthController.handleOpenUrl(url: url)
//         }
        var result = false

        NSLog("URL = \(url.absoluteString)");

        if url.absoluteString.hasPrefix("kakao"){
            result = super.application(app, open: url, options: options)
                }
        if !result {
            result = NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)

        }
        return NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
    }
}
