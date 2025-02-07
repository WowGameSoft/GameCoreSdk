//
//  ViewContentSwiftUI.swift
//
//  Created by iMac on 07/02/2025.
//

import Foundation
import SwiftUI

public struct ViewContentSwiftUI: UIViewControllerRepresentable {
    public var errorDetail: String
    
    public init(errorDetail: String) {
        self.errorDetail = errorDetail
    }
    
    public func makeUIViewController(context: Context) -> CheckController {
        let viewController = CheckController()
        viewController.errorURL = errorDetail
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: CheckController, context: Context) {}
}
