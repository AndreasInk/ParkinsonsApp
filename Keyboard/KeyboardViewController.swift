//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Andreas on 5/31/21.
//

import UIKit
import SwiftUI
class KeyboardViewController: UIInputViewController {


    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton(type: .system)
//
//        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
//
//        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//
//        self.view.addSubview(self.nextKeyboardButton)
//
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//
       
        let child = UIHostingController(rootView: Keyboard(viewController: self))
            //that's wrong, it must be true to make flexible constraints work
           // child.translatesAutoresizingMaskIntoConstraints = false
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(child.view)
        
            addChild(child)
        
    }
    override func viewDidAppear(_ animated: Bool) {
//        var heightConstraint = NSLayoutConstraint(item: self.view!, attribute:.height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 600)
//          heightConstraint.priority = .init(999)
//          self.view.addConstraint(heightConstraint)
//
    
    }
    override func viewWillLayoutSubviews() {
       
        super.viewWillLayoutSubviews()
    }
  
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
      
    }

}
