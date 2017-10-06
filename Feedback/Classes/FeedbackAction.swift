//
//  FeedbackAction.swift
//  Alamofire
//
//  Created by Lukasz on 06/10/2017.
//

import Foundation

public enum FeedbackAction {
    case selectRating(rating: Int)
    case submit(content: String)
}

