//
//  ViewController.swift
//  Feedback
//
//  Created by Lukasz on 10/06/2017.
//  Copyright (c) 2017 Lukasz. All rights reserved.
//

import UIKit
import LPM_Feedback
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let button = UIButton(type: .custom)
        view.addSubview(button)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("START FEEDBACK", for: .normal)
        
        let size = CGSize(width: 200, height: 100)
        button.frame = CGRect(x: view.bounds.size.width / 2 - size.width / 2, y: view.bounds.size.height / 2 - size.height / 2, width: size.width, height: size.height)
        
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    func tap() {
        // configure feedback
        
        // required: email
        FeedbackConfiguration.Email = "current_user@email.com"
        
        // required: api url
        FeedbackConfiguration.Api = "http://apps-ghpsj.lespetitesmains.net/rate_douleur.php"
        
        // optional:
        FeedbackConfiguration.Title = "Donnez-nous votre avis"
        FeedbackConfiguration.RatingHint = "Etes-vous satisfait(e) de l'application ?"
        FeedbackConfiguration.FeedbackHint = "Faites nous part de vos commentaires ou suggestions :"
        
        navigationController?.pushViewController(FeedbackController(), animated: true)
    }
}

