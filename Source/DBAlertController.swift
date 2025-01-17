//
//  DBAlertController.swift
//  DBAlertController
//
//  Originally created by Dylan Bettermann on 5/11/15.
//  Copyright (c) 2015 Dylan Bettermann. All rights reserved.
//
//  Updates by Bran Handley
//

import UIKit

open class DBAlertController: UIAlertController {
   
    /// The UIWindow that will be at the top of the window hierarchy. The DBAlertController instance is presented on the rootViewController of this window.
    fileprivate lazy var alertWindow: UIWindow = {
        let window: UIWindow
        if let currentScene = currentWindowScene() {
            window = UIWindow(windowScene: currentScene)
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        window.rootViewController = DBClearViewController()
        window.backgroundColor = .clear
        window.windowLevel = UIWindow.Level.alert
        return window
    }()
    
    /**
    Present the DBAlertController on top of the visible UIViewController.
    
    - parameter flag:       Pass true to animate the presentation; otherwise, pass false. The presentation is animated by default.
    - parameter completion: The closure to execute after the presentation finishes.
    */
    open func show(animated flag: Bool = true, completion: (() -> Void)? = nil) {
        if let rootViewController = alertWindow.rootViewController {
            alertWindow.makeKeyAndVisible()
            
            rootViewController.present(self, animated: flag, completion: completion)
        }
    }
    
    /**
     Attempt to find the window scene of the current window
     
     - Note: This may not work well in multi-scene apps - untested
     */
    func currentWindowScene() -> UIWindowScene? {
        let scenes = UIApplication.shared.connectedScenes.compactMap({$0 as? UIWindowScene})
        for scene in scenes {
            if #available(iOS 15.0, *) {
                if let keyWindow = scene.keyWindow {
                    return keyWindow.windowScene
                }
            } else {
                // Fallback on earlier versions
                if let keyWindow = scene.windows.first(where: { $0.isKeyWindow }) {
                    return keyWindow.windowScene
                }
            }
        }
        return nil
    }
    
}

// In the case of view controller-based status bar style, make sure we use the same style for our view controller
private class DBClearViewController: UIViewController {
    
    fileprivate override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({$0 as? UIWindowScene})
            .first?.statusBarManager?.statusBarStyle ?? UIStatusBarStyle.default
    }
    
    fileprivate override var prefersStatusBarHidden: Bool {
        return UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({$0 as? UIWindowScene})
            .first?.statusBarManager?.isStatusBarHidden ?? false
    }
    
}
