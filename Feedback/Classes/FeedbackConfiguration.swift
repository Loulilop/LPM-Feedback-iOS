//
//  FeedbackConfiguration.swift
//  Alamofire
//
//  Created by Lukasz on 06/10/2017.
//

import Foundation
import SwiftCommons

public struct FeedbackConfiguration {
    public static var Title = "Donnez-nous votre avis"
    public static var RatingHint = "Etes-vous satisfait(e) de l'application ?"
    public static var FeedbackHint = "Faites nous part de vos commentaires ou suggestions :"
    public static var Rate0 = "Pas du tout satisfait(e)"
    public static var Rate1 = "Pas très satisfait(e)"
    public static var Rate2 = "Plutôt satisfait(e)"
    public static var Rate3 = "Très satisfait(e)"
    
    public static var AutoKeyboardManager = true
    public static var Email = ""
    public static var Api = ""
    
    public static var NetworkFailure = "Une erreur s'est produite. Veuillez ré-essayer."
    public static var NetworkNotConnected = "Vous n'êtes pas connectés à internet"
}
