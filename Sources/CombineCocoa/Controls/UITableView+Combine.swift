//
//  UITableView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 19/01/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit) && canImport(UIKit) && !(os(iOS) && (arch(i386) || arch(arm)))
    import Combine
    import Foundation
    import UIKit

    // swiftlint:disable force_cast
    @available(iOS 13.0, *)
    public extension UITableView {
        /// Combine wrapper for `tableView(_:willDisplay:forRowAt:)`
        var willDisplayCellPublisher: AnyPublisher<(cell: UITableViewCell, indexPath: IndexPath), Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:willDisplay:forRowAt:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { ($0[1] as! UITableViewCell, $0[2] as! IndexPath) }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:willDisplayHeaderView:forSection:)`
        var willDisplayHeaderViewPublisher: AnyPublisher<(headerView: UIView, section: Int), Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:willDisplayHeaderView:forSection:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { ($0[1] as! UIView, $0[2] as! Int) }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:willDisplayFooterView:forSection:)`
        var willDisplayFooterViewPublisher: AnyPublisher<(footerView: UIView, section: Int), Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:willDisplayFooterView:forSection:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { ($0[1] as! UIView, $0[2] as! Int) }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:didEndDisplaying:forRowAt:)`
        var didEndDisplayingCellPublisher: AnyPublisher<(cell: UITableViewCell, indexPath: IndexPath), Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:didEndDisplaying:forRowAt:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { ($0[1] as! UITableViewCell, $0[2] as! IndexPath) }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:didEndDisplayingHeaderView:forSection:)`
        var didEndDisplayingHeaderViewPublisher: AnyPublisher<(headerView: UIView, section: Int), Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:didEndDisplayingHeaderView:forSection:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { ($0[1] as! UIView, $0[2] as! Int) }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:didEndDisplayingFooterView:forSection:)`
        var didEndDisplayingFooterView: AnyPublisher<(headerView: UIView, section: Int), Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:didEndDisplayingFooterView:forSection:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { ($0[1] as! UIView, $0[2] as! Int) }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:accessoryButtonTappedForRowWith:)`
        var itemAccessoryButtonTappedPublisher: AnyPublisher<IndexPath, Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:accessoryButtonTappedForRowWith:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { $0[1] as! IndexPath }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:didHighlightRowAt:)`
        var didHighlightRowPublisher: AnyPublisher<IndexPath, Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:didHighlightRowAt:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { $0[1] as! IndexPath }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:didUnHighlightRowAt:)`
        var didUnhighlightRowPublisher: AnyPublisher<IndexPath, Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:didUnhighlightRowAt:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { $0[1] as! IndexPath }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:didSelectRowAt:)`
        var didSelectRowPublisher: AnyPublisher<IndexPath, Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { $0[1] as! IndexPath }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:didDeselectRowAt:)`
        var didDeselectRowPublisher: AnyPublisher<IndexPath, Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:didDeselectRowAt:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { $0[1] as! IndexPath }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:willBeginEditingRowAt:)`
        var willBeginEditingRowPublisher: AnyPublisher<IndexPath, Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:willBeginEditingRowAt:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { $0[1] as! IndexPath }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:didEndEditingRowAt:)`
        var didEndEditingRowPublisher: AnyPublisher<IndexPath, Never> {
            let selector = #selector(UITableViewDelegate.tableView(_:didEndEditingRowAt:))
            return delegateProxy.interceptSelectorPublisher(selector)
                .map { $0[1] as! IndexPath }
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:prefetchRowsAt:)`
        var prefetchItemsAtPublisher: AnyPublisher<[IndexPath], Never> {
            (prefetchingDelegateProxy as! TableViewDataSourcePrefetchingProxy)
                .prefetchItemsSubject
                .eraseToAnyPublisher()
        }

        /// Combine wrapper for `tableView(_:cancelPrefetchingForRowsAt:)`
        var cancelPrefetchingForItemsAtPublisher: AnyPublisher<[IndexPath], Never> {
            let selector = #selector(UITableViewDataSourcePrefetching.tableView(_:cancelPrefetchingForRowsAt:))
            return prefetchingDelegateProxy.interceptSelectorPublisher(selector)
                .map { $0[1] as! [IndexPath] }
                .eraseToAnyPublisher()
        }

        override var delegateProxy: DelegateProxy {
            TableViewDelegateProxy.createDelegateProxy(for: self)
        }

        var prefetchingDelegateProxy: DelegateProxy {
            TableViewDataSourcePrefetchingProxy.createDelegateProxy(for: self)
        }
    }

    @available(iOS 13.0, *)
    private class TableViewDelegateProxy: DelegateProxy, UITableViewDelegate, DelegateProxyType {
        func setDelegate(to object: UITableView) {
            object.delegate = self
        }
    }

    @available(iOS 13.0, *)
    class TableViewDataSourcePrefetchingProxy: DelegateProxy, UITableViewDataSourcePrefetching, DelegateProxyType {
        let prefetchItemsSubject = PassthroughSubject<[IndexPath], Never>()

        func setDelegate(to object: UITableView) {
            object.prefetchDataSource = self
        }

        func tableView(_: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
            prefetchItemsSubject.send(indexPaths)
        }
    }
#endif
// swiftlint:enable force_cast
