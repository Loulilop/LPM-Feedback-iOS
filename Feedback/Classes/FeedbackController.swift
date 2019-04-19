//
//  FeedbackController.swift
//  Feedback
//
//  Created by Lukasz on 06/10/2017.
//

import UIKit
import SwiftCommons
import IQKeyboardManagerSwift

public class FeedbackController: BaseController<FeedbackReactor, FeedbackView> {
    
    public override func setup() {
        reactor = FeedbackReactor()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = FeedbackConfiguration.Title
        
        contentView.controller = self
        
        contentView.router = { [unowned self] navigation in
            switch navigation {
            case .back:
                self.navigationController!.popViewController(animated: true)
                return true
            case .none: return false
            }
        }
        
        if FeedbackConfiguration.AutoKeyboardManager {
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "OK"
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController!.setNavigationBarHidden(false, animated: true)
        navigationController!.navigationBar.isTranslucent = false
        
        if let c = navigationController, let topItem = c.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem.m_create { $0.title = "" }
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if FeedbackConfiguration.AutoKeyboardManager {
            IQKeyboardManager.shared.enable = false
        }
    }
}
