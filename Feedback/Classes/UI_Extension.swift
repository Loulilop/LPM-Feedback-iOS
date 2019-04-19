//
//  UI_Extension.swift
//  Alamofire
//
//  Created by Lukasz on 06/10/2017.
//

import UIKit

internal extension UIColor {
    
    convenience init(rgb: UInt, alpha: Float = 1) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha))
    }
}

internal extension UIButton {
    
    var horizontalPadding: CGFloat {
        get {
            fatalError()
        }
        
        set {
            contentHorizontalAlignment = .left
            contentEdgeInsets = UIEdgeInsets(top: 0, left: newValue, bottom: 0, right: newValue)
        }
    }
    
    var title: String {
        get {
            fatalError()
        }
        
        set {
            setTitle(newValue, for: UIControl.State())
        }
    }
}

extension UIImage {
    internal static func named(_ name: String) -> UIImage {
        let bundle = Bundle(url: Bundle(for: FeedbackController.self).url(forResource: "LPM-Feedback", withExtension: "bundle")!)!
        return UIImage(named: name, in: bundle, compatibleWith: nil)!
    }
}
