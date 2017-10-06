//
//  FeedbackState.swift
//  Alamofire
//
//  Created by Lukasz on 06/10/2017.
//

import Foundation
import Reactored
import SwiftCommons

public struct FeedbackState: ReactorState {
    
    enum Navigation {
        case none
        case back
    }
    
    static func initial() -> FeedbackState {
        return FeedbackState(
            navigation: .none,
            rating: -1,
            isErrorRatingMissing: false,
            submitTask: Task.idle
        )
    }
    
    var navigation: Navigation
    var rating: Int
    var isErrorRatingMissing: Bool
    var submitTask: Task<Void>
}

extension FeedbackState: Equatable {}
public func ==(lhs: FeedbackState, rhs: FeedbackState) -> Bool {
    return
        lhs.navigation == rhs.navigation &&
            lhs.rating == rhs.rating &&
            lhs.isErrorRatingMissing == rhs.isErrorRatingMissing &&
            lhs.submitTask == rhs.submitTask
}
