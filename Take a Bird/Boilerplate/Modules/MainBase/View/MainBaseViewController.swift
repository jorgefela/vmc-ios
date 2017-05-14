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
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPasword: UITextField!
    
    @IBOutlet weak var btnLogIn: UIButton!
    
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
    
    @IBAction func funcbtnLogIn() {
        
        presenter?.pLogIn()
    }
    

    @IBAction func funcBtnRegister(_ sender: UIButton) {
        print("cargando vista regiester")
        presenter?.pRegister()
    }
    
    
    // MARK: Private
    
    private func setupView() {
        
        setupBotonLogIn()
        
        setupInputsBase()
        
    }
    
    func moveToNextField(_ view: UIView, nextFieldTag: Int) {
        let nextResponder = view.superview?.viewWithTag(nextFieldTag) as UIResponder!
        if (nextResponder != nil) {
            nextResponder?.becomeFirstResponder()
        } else {
            view.resignFirstResponder()
            funcbtnLogIn()
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
    
    //TODO: Implementar métodos MainBaseView aquí
    
    func setupBotonLogIn(){
        // TODO: Color de borde bonton
        btnLogIn.backgroundColor = .clear
        btnLogIn.layer.cornerRadius = 2
        btnLogIn.layer.borderWidth = 1
        let verdeManzana : UIColor = UIColor.verdeManzana
        btnLogIn.layer.borderColor = verdeManzana.cgColor
    }
    
    func setupInputsBase(){
        // TODO: Estilo Inputs Login
        // transparencia de bordes
        txtEmail.backgroundColor = UIColor.white.withAlphaComponent(0.0000001)
        txtPasword.backgroundColor = UIColor.white.withAlphaComponent(0.0000001)
        // Color de texto
        txtEmail.font = UIFont(name: "HelveticaNeue", size: 17)!
        txtPasword.font = UIFont(name: "HelveticaNeue", size: 17)!
        txtPasword.textColor = UIColor.white
        txtEmail.textColor = UIColor.white
    }
    
}
