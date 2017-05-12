//
//  MainBaseViewController.swift
//  Boilerplate
//
//  Created by macbook3 on 12/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

import UIKit

class MainBaseViewController: BaseViewController {
    
    // MARK: Static
    
    static let storyboardName = "MainBaseStoryboard"
    
    // MARK: Properties
    
    var presenter: MainBasePresentation?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardNotification()
    }
    
    // MARK: IBActions
    
    @IBAction func onDoSomethinClicked() {
        print("aqui si presione")
        presenter?.doSomething()
    }
    
    // MARK: Private
    
    private func setupView() {
        // TODO: Setup view here
    }
    
    func moveToNextField(_ view: UIView, nextFieldTag: Int) {
        let nextResponder = view.superview?.viewWithTag(nextFieldTag) as UIResponder!
        if (nextResponder != nil) {
            nextResponder?.becomeFirstResponder()
        } else {
            view.resignFirstResponder()
            onDoSomethinClicked()
        }
    }
    
    private func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let info = notification.userInfo,
            let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height + 15.0, 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        guard let activeFieldPresent = findActiveTextField(view.subviews) else { return }
        
        if (!aRect.contains(activeFieldPresent.frame.origin))
        {
            self.scrollView.scrollRectToVisible(activeFieldPresent.frame, animated: true)
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsetsMake(60.0, 0.0, 0.0, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
}

extension  MainBaseViewController: MainBaseView {
    
    //TODO: Implement MainSearchView methods here
    
}
