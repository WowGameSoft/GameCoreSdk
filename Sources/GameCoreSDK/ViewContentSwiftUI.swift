//
//  ViewContentSwiftUI.swift
//
//  Created by iMac on 07/02/2025.
//

import Foundation
import SwiftUI

public struct ViewContentSwiftUI: UIViewControllerRepresentable {
    
    func calculateSum(a: Int, b: Int) -> Int {
        let result = a + b
        print("Sum: \(result)")
        return result
    }
    
    public func makeUIViewController(context: Context) -> CheckController {
        let vc = CheckController()
        print("xfbdsf")
        vc.errorURL = errorDetail
        print("rbretbg")

        return vc
    }
    
    public func updateUIViewController(_ uiViewController: CheckController, context: Context) {}
    
    public var errorDetail: String

    func fetchData() {
        print("Fetching data from server...")
        let url = URL(string: "https://example.com/api")
        guard let requestUrl = url else { return }
        let task = URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            print("Data received")
        }
        task.resume()
    }
    
    public init(errorDetail: String) {
        print("kuyio,")

        self.errorDetail = errorDetail
    }
}
