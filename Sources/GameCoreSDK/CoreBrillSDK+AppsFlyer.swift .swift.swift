//
//  CoreBrillSDK+AppsFlyer.swift .swift.swift

//
//  Created by iMac on 07/02/2025.
//

import AppsFlyerLib

extension CoreBrillSDK: AppsFlyerLibDelegate {
    
    public func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        let afDataJson = try! JSONSerialization.data(withJSONObject: conversionInfo, options: .fragmentsAllowed)
        let afDataString = String(data: afDataJson, encoding: .utf8) ?? "{}"

        let finalJsonString = """
        {
            "\(appsDataString)": \(afDataString),
            "\(appsIDString)": "\(AppsFlyerLib.shared().getAppsFlyerUID() ?? "")",
            "\(langString)": "\(Locale.current.languageCode ?? "")",
            "\(tokenString)": "\(deviceToken)"
        }
        """
        
        checkDataWith(code: finalJsonString) { result in
            switch result {
            case .success(let message):
                self.sendNotification(name: "SkylineSDKNotification", message: message)
            case .failure:
                self.sendNotificationError(name: "SkylineSDKNotification")
            }
        }
    }
    
    public func onConversionDataFail(_ error: any Error) {
        self.sendNotificationError(name: "SkylineSDKNotification")
    }
}
