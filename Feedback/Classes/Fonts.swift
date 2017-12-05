//
//  Fonts.swift
//  Alamofire
//
//  Created by Lukasz on 06/10/2017.
//

import UIKit

internal class Fonts {
    
    internal static let instance = Fonts()
    
    internal func openSansRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans", size: size)!
    }
    
    private init() {
        try! loadFont("OpenSans-Regular")
    }
    
    private func loadFont(_ name: String) throws {
        let bundle = Bundle(url: Bundle(for: Fonts.self).url(forResource: "LPM-Feedback", withExtension: "bundle")!)!
        let url = bundle.url(forResource: name, withExtension: "ttf")!
        let fontData = NSData(contentsOf: url)!
        let dataProvider = CGDataProvider(data: fontData)!
        let fontRef = CGFont(dataProvider)!
        
        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
            throw NSError(domain: "Failed to register font", code: 0, userInfo: nil)
        }
    }
}
