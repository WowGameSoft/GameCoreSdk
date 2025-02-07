
import Foundation
import AppsFlyerLib
import Alamofire
import SwiftUI
import Combine
import WebKit

public class CoreBrillSDK: NSObject {
    public static let shared = CoreBrillSDK()

    public func initialize(
        application: UIApplication,
        window: UIWindow,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        
        self.appsDataString = "playData"
        self.appsIDString = "playId"
        self.langString = "playlng"
        self.tokenString = "palytok"
        self.lock = "https://cuuqow.top/cleopatra/"
        self.paramName = "error"
        self.mainWindow = window
        
        
        AppsFlyerLib.shared().appsFlyerDevKey = "WB3x6q6LTLZE5fkjCqM2p"
        AppsFlyerLib.shared().appleAppID = "6740704768"
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().disableAdvertisingIdentifier = true
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            } else {
                print("Notification permission denied.")
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSessionDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        
        completion(.success("Initialization completed successfully"))
    }
    
    @AppStorage("initialStart") var initialStart: String?
    @AppStorage("statusFlag") var statusFlag: Bool = false
    @AppStorage("finalData") var finalData: String?
    
    var hasSessionStarted = false
    var deviceToken: String = ""
    var session: Session
    var cancellables = Set<AnyCancellable>()
    
    var appsDataString: String = ""
    var appsIDString: String = ""
    var langString: String = ""
    var tokenString: String = ""
    
    var lock: String = ""
    var paramName: String = ""
    var mainWindow: UIWindow?
    
    @objc private func handleSessionDidBecomeActive() {
           if !self.hasSessionStarted {
               AppsFlyerLib.shared().start()
               self.hasSessionStarted = true
           }
       }
    
    private override init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20
        sessionConfig.timeoutIntervalForResource = 20
        self.session = Alamofire.Session(configuration: sessionConfig)
    }
    
    
}
