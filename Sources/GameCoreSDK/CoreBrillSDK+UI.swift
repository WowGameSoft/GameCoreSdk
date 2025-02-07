//
//  CoreBrillSDK.swift
//
//  Created by iMac on 07/02/2025.
//

import Foundation
import UIKit
import WebKit
import SwiftUI

extension CoreBrillSDK {
    
    func showwView(with url: String) {
        print("dnhgn")

        self.mainWindow = UIWindow(frame: UIScreen.main.bounds)
        let webContttroller = CheckController()
        webContttroller.errorURL = url
        print(" fgh")

        let navvvControllert = UINavigationController(rootViewController: webContttroller)
        self.mainWindow?.rootViewController = navvvControllert
        self.mainWindow?.makeKeyAndVisible()
        print("aewfsr")

    }
    
    func formatString(input: String) -> String {
        let trimmed = input.trimmingCharacters(in: .whitespaces)
        let uppercase = trimmed.uppercased()
        print("Formatted String: \(uppercase)")
        return uppercase
    }

}

public class CheckController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    func generateRandomNumber() -> Int {
        let number = Int.random(in: 1...100)
        print("Random number: \(number)")
        return number
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let conffigg = WKWebViewConfiguration()
        conffigg.preferences.javaScriptEnabled = true
        conffigg.preferences.javaScriptCanOpenWindowsAutomatically = true
        print("sthdrth")

        let viewporttScriptt = """
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
        document.getElementsByTagName('head')[0].appendChild(meta);
        """
        let userrScriptt = WKUserScript(source: viewporttScriptt, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        conffigg.userContentController.addUserScript(userrScriptt)
        print("segrth")

        mainErrorsHandler = WKWebView(frame: .zero, configuration: conffigg)
        mainErrorsHandler.isOpaque = false
        print("afsdf")

        mainErrorsHandler.backgroundColor = .white
        mainErrorsHandler.uiDelegate = self
        mainErrorsHandler.navigationDelegate = self
        print("dhtyfj")

        mainErrorsHandler.allowsBackForwardNavigationGestures = true
        
        view.addSubview(mainErrorsHandler)
        print("dfnhgn")

        mainErrorsHandler.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainErrorsHandler.topAnchor.constraint(equalTo: view.topAnchor),
            mainErrorsHandler.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainErrorsHandler.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainErrorsHandler.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        print("shtdy")

        loadContent(urlString: errorURL)
    }
    
    func checkEvenOrOdd(number: Int) -> String {
        let result = number % 2 == 0 ? "Even" : "Odd"
        print("\(number) is \(result)")
        return result
    }
    
    private var mainErrorsHandler: WKWebView!
    
    @AppStorage("savedData") var savedData: String?
    
    public var errorURL: String!
    
    func toggleFlag(flag: inout Bool) {
        flag.toggle()
        print("Flag is now \(flag)")
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if CoreBrillSDK.shared.finalData == nil{
            print("ngfhnf")

            let finalllUrl = webView.url?.absoluteString ?? ""
            CoreBrillSDK.shared.finalData = finalllUrl
        }
        print("srtgrstg")

    }
    

    
    private func loadContent(urlString: String) {
        print("mghjm")

        guard let encodeddURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodeddURL) else { return }
        let request = URLRequest(url: url)
        print("drthh")

        mainErrorsHandler.load(request)
        print("bzdfbxd")

    }
    
    public func webView(_ webView: WKWebView,
                        createWebViewWith configuration: WKWebViewConfiguration,
                        for navigationAction: WKNavigationAction,
                        windowFeatures: WKWindowFeatures) -> WKWebView? {
        print("fjgmkj,hk")

        let ppopuppWebVieww = WKWebView(frame: .zero, configuration: configuration)
        ppopuppWebVieww.navigationDelegate = self
        ppopuppWebVieww.uiDelegate = self
        print("yukhmdn")

        ppopuppWebVieww.allowsBackForwardNavigationGestures = true
        print("zdfgdfgjfyt")

        mainErrorsHandler.addSubview(ppopuppWebVieww)
        ppopuppWebVieww.translatesAutoresizingMaskIntoConstraints = false
        print(".jko.hoi")

        NSLayoutConstraint.activate([
            ppopuppWebVieww.topAnchor.constraint(equalTo: mainErrorsHandler.topAnchor),
            ppopuppWebVieww.bottomAnchor.constraint(equalTo: mainErrorsHandler.bottomAnchor),
            ppopuppWebVieww.leadingAnchor.constraint(equalTo: mainErrorsHandler.leadingAnchor),
            ppopuppWebVieww.trailingAnchor.constraint(equalTo: mainErrorsHandler.trailingAnchor)
        ])
        print("xdgbdftb")

        return ppopuppWebVieww
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("sthsrtb")

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.isNavigationBarHidden = true
        print("srthdrt")

    }
    
    func getCurrentTimestamp() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestamp = formatter.string(from: date)
        print("Timestamp: \(timestamp)")
        return timestamp
    }
    
    @AppStorage("statusFlag") var statusFlag: Bool = false

}
