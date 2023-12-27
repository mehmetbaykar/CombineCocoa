//
//  WKWebView+Combine.swift
//
//
//  Created by Chanchana Koedtho on 11/12/2566 BE.
//

#if canImport(UIKit) && !(os(iOS) && (arch(i386) || arch(arm)))
    import Combine
    import Foundation
    import WebKit

    @available(iOS 13.0, *)
    public extension WKWebView {
        // Combine wraper for `WKNavigationDelegate.webView(_:didCommit:)`
        var didCommit: AnyPublisher<WKNavigation, Never> {
            let selector = #selector(WKNavigationDelegate.webView(_:didCommit:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { ($0[1] as! WKNavigation) }
                .eraseToAnyPublisher()
        }

        // Combine wraper for `WKNavigationDelegate.webView(_:didFinish:)`
        var didFinishLoad: AnyPublisher<WKNavigation, Never> {
            let selector = #selector(WKNavigationDelegate.webView(_:didFinish:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { ($0[1] as! WKNavigation) }
                .eraseToAnyPublisher()
        }

        // Combine wraper for `WKNavigationDelegate.webView(_:didStartProvisionalNavigation:)`
        var didStartLoad: AnyPublisher<WKNavigation, Never> {
            let selector = #selector(WKNavigationDelegate.webView(_:didStartProvisionalNavigation:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { ($0[1] as! WKNavigation) }
                .eraseToAnyPublisher()
        }

        // Combine wraper for `WKNavigationDelegate.webView(_:didFail:withError:)`
        var didFailLoad: AnyPublisher<(WKNavigation, Error), Never> {
            let selector = #selector(WKNavigationDelegate.webView(_:didFail:withError:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { ($0[1] as! WKNavigation, $0[2] as! Error) }
                .eraseToAnyPublisher()
        }

        var delegateProxy: DelegateProxy {
            WKWebViewDelegateProxy.createDelegateProxy(for: self)
        }
    }

    @available(iOS 13.0, *)
    private class WKWebViewDelegateProxy: DelegateProxy, WKNavigationDelegate, DelegateProxyType {
        func setDelegate(to object: WKWebView) {
            object.navigationDelegate = self
        }

        func webView(_: WKWebView, decidePolicyFor _: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
            decisionHandler(.allow, preferences)
        }

        func webView(_: WKWebView, didReceive _: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            completionHandler(.useCredential, nil)
        }

        func webView(_: WKWebView, decidePolicyFor _: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            decisionHandler(.allow)
        }
    }
#endif
