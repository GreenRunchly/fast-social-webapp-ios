//
//  ViewController.swift
//  FastSocial
//
//  Created by Rizki Dashie Dash on 10/07/23.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
//    let webView: WKWebView = {
//        let pengaturan = WKWebpagePreferences()
//        pengaturan.allowsContentJavaScript = true
//        let konfigurasi = WKWebViewConfiguration()
//        konfigurasi.defaultWebpagePreferences = pengaturan
//        let webView = WKWebView(frame: .zero, configuration: konfigurasi)
//        return webView
//    }()
    
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = view.bounds
        webView.navigationDelegate = self
        
        guard let targetUrl = URL(string: "https://fasturl.cloud/FastSocial") else {
            return;
        }
        
        webView.load(URLRequest(url: targetUrl))
        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(webView)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated  {
                if let url = navigationAction.request.url,
                    let host = url.host, !host.hasPrefix("fasturl.cloud/FastSocial"),
                    UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                    print(url)
                    print("Redirected to browser. No need to open it locally")
                    decisionHandler(.cancel)
                    return
                } else {
                    print("Open it locally")
                    decisionHandler(.allow)
                    return
                }
            } else {
                print("not a user click")
                decisionHandler(.allow)
                return
            }
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

}
