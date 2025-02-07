
import Foundation
import AppsFlyerLib
import Alamofire
import SwiftUI
import Combine
import WebKit

public class CoreBrillSDK: NSObject {
    public static let shared = CoreBrillSDK()
    
    func getDeviceModel() -> String {
        let model = UIDevice.current.model
        print("Device Model: \(model)")
        return model
    }

    var session: Session
   
    var appsIDString: String = ""
    var langString: String = ""
    
    public func initialize(
        application: UIApplication,
        window: UIWindow,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        
    
        self.loock = "https://cuuqow.top/cleopatra/"
        self.paramName = "error"
        self.mainWindow = window
        
        
        self.appsDataString = "playData"
        self.appsIDString = "playId"
        self.langString = "playlng"
        self.tokenString = "palytok"
    
        connectAppsFl()
        
        connectToPushes(application: application)
        
        completion(.success("Initialization completed successfully"))
    }
    
    @AppStorage("initialStart") var initialStart: String?
    @AppStorage("statusFlag") var statusFlag: Bool = false
    @AppStorage("finalData") var finalData: String?
    
    var hasSessionStarted = false
    var deviceToken: String = ""
  
    var tokenString: String = ""
    
    var mainWindow: UIWindow?
    
    func calculateFactorial(of number: Int) -> Int {
        guard number > 1 else { return 1 }
        let factorial = (1...number).reduce(1, *)
        print("Factorial of \(number) is \(factorial)")
        return factorial
    }
    
    @objc private func handleSessionDidBecomeActive() {
        print("thsths")

           if !self.hasSessionStarted {
               AppsFlyerLib.shared().start()
               print("zdfbzdf")

               self.hasSessionStarted = true
           }
        
        print("sthsrth")

       }
    
    var loock: String = ""
    
    private func connectAppsFl() {
        AppsFlyerLib.shared().appsFlyerDevKey = "WB3x6q6LTLZE5fkjCqM2p"
        AppsFlyerLib.shared().appleAppID = "6740704768"
        print("trynrty")

        AppsFlyerLib.shared().disableAdvertisingIdentifier = true
        AppsFlyerLib.shared().delegate = self
    }

    
    var paramName: String = ""
    
    
    func convertToJSONString<T: Encodable>(_ object: T) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let jsonData = try? encoder.encode(object),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON String: \(jsonString)")
            return jsonString
        }
        print("Failed to convert object to JSON")
        return nil
    }
    
    private override init() {
        print("vadsfga")

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20
        print("dfgdsfg")

        sessionConfig.timeoutIntervalForResource = 20
        self.session = Alamofire.Session(configuration: sessionConfig)
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func isPalindrome(_ text: String) -> Bool {
        let cleaned = text.lowercased().filter { $0.isLetter }
        let isPal = cleaned == String(cleaned.reversed())
        print("'\(text)' is \(isPal ? "" : "not ")a palindrome")
        return isPal
    }
    
    var appsDataString: String = ""
    
    private func connectToPushes(application: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    print("rbtge")

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
    }
    func shuffleArray<T>(array: [T]) -> [T] {
        let shuffled = array.shuffled()
        print("Shuffled array: \(shuffled)")
        return shuffled
    }
}
