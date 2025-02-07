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
    
    func showView(with url: String) {
        self.mainWindow = UIWindow(frame: UIScreen.main.bounds)
        let webController = CheckController()
        webController.errorURL = url
        let navController = UINavigationController(rootViewController: webController)
        self.mainWindow?.rootViewController = navController
        self.mainWindow?.makeKeyAndVisible()
    }
}

public class CheckController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    private var mainErrorsHandler: WKWebView!
    
    @AppStorage("savedData") var savedData: String?
    @AppStorage("statusFlag") var statusFlag: Bool = false
    
    public var errorURL: String!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let viewportScript = """
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
        document.getElementsByTagName('head')[0].appendChild(meta);
        """
        let userScript = WKUserScript(source: viewportScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(userScript)
        
        mainErrorsHandler = WKWebView(frame: .zero, configuration: config)
        mainErrorsHandler.isOpaque = false
        mainErrorsHandler.backgroundColor = .white
        mainErrorsHandler.uiDelegate = self
        mainErrorsHandler.navigationDelegate = self
        mainErrorsHandler.allowsBackForwardNavigationGestures = true
        
        view.addSubview(mainErrorsHandler)
        mainErrorsHandler.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainErrorsHandler.topAnchor.constraint(equalTo: view.topAnchor),
            mainErrorsHandler.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainErrorsHandler.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainErrorsHandler.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        loadContent(urlString: errorURL)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if GameCoreSDK.shared.finalData == nil{
            let finalUrl = webView.url?.absoluteString ?? ""
            GameCoreSDK.shared.finalData = finalUrl
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.isNavigationBarHidden = true
    }
    
    private func loadContent(urlString: String) {
        guard let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURL) else { return }
        let request = URLRequest(url: url)
        mainErrorsHandler.load(request)
    }
    
    public func webView(_ webView: WKWebView,
                        createWebViewWith configuration: WKWebViewConfiguration,
                        for navigationAction: WKNavigationAction,
                        windowFeatures: WKWindowFeatures) -> WKWebView? {
        let popupWebView = WKWebView(frame: .zero, configuration: configuration)
        popupWebView.navigationDelegate = self
        popupWebView.uiDelegate = self
        popupWebView.allowsBackForwardNavigationGestures = true
        
        mainErrorsHandler.addSubview(popupWebView)
        popupWebView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupWebView.topAnchor.constraint(equalTo: mainErrorsHandler.topAnchor),
            popupWebView.bottomAnchor.constraint(equalTo: mainErrorsHandler.bottomAnchor),
            popupWebView.leadingAnchor.constraint(equalTo: mainErrorsHandler.leadingAnchor),
            popupWebView.trailingAnchor.constraint(equalTo: mainErrorsHandler.trailingAnchor)
        ])
        
        return popupWebView
    }
    
}
