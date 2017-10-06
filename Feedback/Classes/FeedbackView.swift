//
//  FeedbackView.swift
//  Alamofire
//
//  Created by Lukasz on 06/10/2017.
//

import UIKit
import Reactored
import SwiftCommons
import RxSwift
import RxCocoa
import RxGesture
import Mortar
import Keyboardy
import Alertift

public class FeedbackView: BaseControllerView, ReactorView {
    public typealias Action = FeedbackAction
    public typealias State = FeedbackState
    
    var router: ((FeedbackState.Navigation) -> Bool)!
    weak var controller: FeedbackController!
    
    // Widgets
    
    private let messageLabel = UILabel.m_create { v in
        v.font = Fonts.instance.openSansRegular(ofSize: 15.0)
        v.textAlignment = .center
        v.numberOfLines = 0
        v.text = FeedbackConfiguration.RatingHint
    }
    
    private let ratingsView = RatingsView()
    
    private let message2Label = UILabel.m_create { v in
        v.font = Fonts.instance.openSansRegular(ofSize: 15.0)
        v.textAlignment = .center
        v.numberOfLines = 0
        v.text = FeedbackConfiguration.FeedbackHint
    }
    
    private let textView = UITextView.m_create { v in
        v.backgroundColor = UIColor.white
        v.textContainerInset = UIEdgeInsets(top: 10, left: 6, bottom: 10, right: 6)
        v.font = Fonts.instance.openSansRegular(ofSize: 15.0)
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor(rgb: 0x9B9B9B).cgColor
    }
    
    private let submitButton = UIButton.m_create { v in
        v.backgroundColor = UIColor(rgb: 0x3e7cad)
        v.titleLabel!.font = Fonts.instance.openSansRegular(ofSize: 15.0)
        v.setTitle("ENVOYER", for: .normal)
        v.horizontalPadding = 30
        v.m_height |=| 46
    }
    
    private var loginButton: UIButton!
    private var signupButton: UIButton!
    
    public override func setupUI() {
        backgroundColor = UIColor(rgb: 0xF8F8F8)
        
        self |+| [
            messageLabel,
            ratingsView,
            message2Label,
            textView,
            submitButton
        ]
    }
    
    public override func setupConstraints() {
        let hMargin = 20
        visibleRegion |>> hMargin | messageLabel | hMargin
        visibleRegion |>> ratingsView
        visibleRegion |>> hMargin | message2Label | hMargin
        visibleRegion |>> hMargin | textView | hMargin
        visibleRegion |>> ~~1 | submitButton | ~~1
        
        visibleRegion |^^
            20 |
            messageLabel |
            20 |
            ratingsView |
            30 |
            message2Label |
            15 |
            textView[~~1] |
            40 |
            submitButton |
        20
    }
    
    public func bind(state: FeedbackState) {
        ratingsView.bind(state: state)
        
        NotificationHelper.bind(error: "Veuillez faire votre choix", if: state.isErrorRatingMissing)
        
        if state.submitTask.isSuccessful {
            Alertift.alert(title: nil, message: "Merci! Votre avis a bien été pris en compte")
                .action(.default("OK")) { _ in
                    _ = self.router(.back)
                }
                .show(on: controller)
        }
        
        isUserInteractionEnabled = !TaskHelper.bind(task: state.submitTask) && !router(state.navigation)
    }
    
    public func actions() -> Observable<FeedbackAction> {
        return Observable.merge(
            submitButton.rx.tap
                .do(onNext: { self.endEditing(true) })
                .map { FeedbackAction.submit(content: self.textView.text!) },
            ratingsView.actions()
        )
    }
    
    class RatingsView: BaseView {
        
        let rating0 = RatingView(rating: 0)
        let rating1 = RatingView(rating: 1)
        let rating2 = RatingView(rating: 2)
        let rating3 = RatingView(rating: 3)
        
        override func setupUI() {
            self |+| [
                rating0,
                rating1,
                rating2,
                rating3
            ]
        }
        
        override func setupConstraints() {
            let margin = 10//SizeHelper.adaptiveSize(0, 10)
            self |>>
                ~~1 |
                rating0[==80] | margin |
                rating1[==80] | margin |
                rating2[==80] | margin |
                rating3[==80] |
                ~~1
            
            self |^^ rating0
            self |^^ rating1
            self |^^ rating2
            self |^^ rating3
        }
        
        func bind(state: FeedbackState) {
            rating0.bind(isActive: state.rating == 0)
            rating1.bind(isActive: state.rating == 1)
            rating2.bind(isActive: state.rating == 2)
            rating3.bind(isActive: state.rating == 3)
        }
        
        func actions() -> Observable<FeedbackAction> {
            return Observable.merge(
                rating0.rx.tapGesture().when(.recognized).map { _ in .selectRating(rating: 0) },
                rating1.rx.tapGesture().when(.recognized).map { _ in .selectRating(rating: 1) },
                rating2.rx.tapGesture().when(.recognized).map { _ in .selectRating(rating: 2) },
                rating3.rx.tapGesture().when(.recognized).map { _ in .selectRating(rating: 3) }
            )
        }
    }
    
    class RatingView: BaseView {
        
        let rating: Int
        var isActive: Bool!
        
        let imageView = UIImageView.m_create { v in
            
        }
        
        let label = UILabel.m_create { v in
            v.font = Fonts.instance.openSansRegular(ofSize: 13.0)
            v.textAlignment = .center
            v.numberOfLines = 2
            v.textColor = UIColor(rgb: 0x9B9B9B)
        }
        
        required init(rating: Int) {
            self.rating = rating
            super.init()
            
            bind(isActive: false)
        }
        
        required init() {
            fatalError("init() has not been implemented")
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func setupUI() {
            self |+| [
                imageView,
                label
            ]
        }
        
        override func setupConstraints() {
            self |>> ~~1 | imageView | ~~1
            self |>> ~~1 | label | ~~1
            
            self |^^
                imageView |
                4 |
            label
        }
        
        func bind(isActive: Bool) {
            self.isActive = isActive
            
            switch rating {
            case 0:
                imageView.image = UIImage.named(isActive ? "rate_0_active" : "rate_0_inactive")
                label.text = FeedbackConfiguration.Rate0
            case 1:
                imageView.image = UIImage.named(isActive ? "rate_1_active" : "rate_1_inactive")
                label.text = FeedbackConfiguration.Rate1
            case 2:
                imageView.image = UIImage.named(isActive ? "rate_2_active" : "rate_2_inactive")
                label.text = FeedbackConfiguration.Rate2
            case 3:
                imageView.image = UIImage.named(isActive ? "rate_3_active" : "rate_3_inactive")
                label.text = FeedbackConfiguration.Rate3
            default: fatalError()
            }
        }
        
    }
}
