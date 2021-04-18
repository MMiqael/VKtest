//
//  VKAuthController.swift
//  VKtest
//
//  Created by Микаэл Мартиросян on 24.12.2020.
//

import UIKit
import WebKit

class VKAuthController: UIViewController {
    
    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wkWebView.navigationDelegate = self
        
        loadWebView()
    }
    
    func loadWebView() {
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7706260"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "scope", value: "friends, photos, wall, groups"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: "5.126")
                ]

                let request = URLRequest(url: urlComponents.url!)

                wkWebView.load(request)
        
                print(request)
    }
}

// MARK: - Extension

extension VKAuthController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map  { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let accessToken = params["access_token"] else { return }
        guard let userId = params["user_id"] else { return }
        
        Session.shared.token = accessToken
        Session.shared.userId = userId
        
        performSegue(withIdentifier: "fromVKAuthToTabBar", sender: nil)
        
        decisionHandler(.cancel)
    }
}
