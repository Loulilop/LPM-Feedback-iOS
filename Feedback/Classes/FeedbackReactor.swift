//
//  FeedbackReactor.swift
//  Pods
//
//  Created by Lukasz on 06/10/2017.
//

import Foundation
import Reactored
import SwiftCommons
import RxSwift

public class FeedbackReactor: Reactor {
    public typealias View = FeedbackView
    
    public let store: ReactorStore<FeedbackState>
    public let disposeBag = KeyDisposeBag()
    
    init() {
        store = ReactorStore(default: FeedbackState.initial())
        store.afterCommit {
            $0.navigation = .none
            $0.isErrorRatingMissing = false
            $0.submitTask.resetOnTermination()
        }
    }
    
    public func dispatch(action: FeedbackAction) {
        switch action {
        case .selectRating(let rating): selectRating(rating)
        case .submit(let content): submit(content: content)
        }
    }
    
    private func selectRating(_ rating: Int) {
        store.commit { $0.rating = rating }
    }
    
    private func submit(content: String) {
        guard store.state.rating >= 0 else {
            store.commit { $0.isErrorRatingMissing = true }
            return
        }
        
        guard FeedbackConfiguration.Api.isNotBlank else {
            fatalError("Missing: FeedbackConfiguration.Api")
        }
        
        guard FeedbackConfiguration.Email.isNotBlank else {
            fatalError("Missing: FeedbackConfiguration.Email")
        }
        
        TaskConfiguration.genericFailureMessage = FeedbackConfiguration.NetworkFailure
        TaskConfiguration.notConnectedToInternetFailureMessage = FeedbackConfiguration.NetworkNotConnected
        
        Api.api.rx.request(.rate(email: FeedbackConfiguration.Email, score: store.state.rating, comment: content))
            .normalize()
            .map { _ in () }
            .asTask(name: "rate")
            .commit(into: store) { state, task in state.submitTask = task }
            .disposed(by: disposeBag, key: "rate")
    }
}
