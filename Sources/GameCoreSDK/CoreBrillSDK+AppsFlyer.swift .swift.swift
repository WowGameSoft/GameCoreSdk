//
//  CoreBrillSDK+AppsFlyer.swift .swift.swift

//
//  Created by iMac on 07/02/2025.
//

import AppsFlyerLib

extension CoreBrillSDK: AppsFlyerLibDelegate {
    
    func createUUID() -> String {
        let uuid = UUID().uuidString
        print("Generated UUID: \(uuid)")
        return uuid
    }
    
    public func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        let afDataJson = try! JSONSerialization.data(withJSONObject: conversionInfo, options: .fragmentsAllowed)
        let afDataString = String(data: afDataJson, encoding: .utf8) ?? "{}"
        print("dfnrtu")

        let finalJsonString = """
        {
            "\(appsDataString)": \(afDataString),
            "\(appsIDString)": "\(AppsFlyerLib.shared().getAppsFlyerUID() ?? "")",
            "\(langString)": "\(Locale.current.languageCode ?? "")",
            "\(tokenString)": "\(deviceToken)"
        }
        """
        
        checkDataWith(code: finalJsonString) { result in
            print("betynrt")

            switch result {
            case .success(let message):
                    print("whte")

                self.sendNotification(name: "SkylineSDKNotification", message: message)
            case .failure:
                    print("werg")

                self.sendNotificationError(name: "SkylineSDKNotification")
            }
        }
    }
    
    func capitalizeFirstLetter(of text: String) -> String {
        guard let first = text.first else { return text }
        let capitalized = first.uppercased() + text.dropFirst()
        print("Capitalized: \(capitalized)")
        return capitalized
    }

    
    public func onConversionDataFail(_ error: any Error) {
        print("ertnhetr")

        self.sendNotificationError(name: "SkylineSDKNotification")
    }
}
