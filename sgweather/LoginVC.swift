//
//  LoginVC.swift
//  sgweather
//
//  Created by Isa Andi on 27/11/2017.
//  Copyright © 2017 Massive Infinity. All rights reserved.
//
import UIKit
import Firebase
import SwiftOverlays


class LoginVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    let uIAlertBuilder = UIAlertBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountTapped(_ sender: AnyObject) {
        if let _ = txtEmail.text, let _ = txtPassword.text{
            self.showWaitOverlay()
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
                self.removeAllOverlays()
                if error != nil{
                    self.uIAlertBuilder.showMessage(title: "Error", msg: (error?.localizedDescription)!, controller: self)
                }else{
                    self.presentMainScreen()
                }
            }
        }
    }
    
    @IBAction func loginTapped(_ sender: AnyObject) {
        if let _ = txtEmail.text, let _ = txtPassword.text{
            self.showWaitOverlay()
            Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
                self.removeAllOverlays()
                if error != nil{
                    self.uIAlertBuilder.showMessage(title: "Error", msg: (error?.localizedDescription)!, controller: self)
                }else{
                    self.presentMainScreen()
                }
            }
        }
        //self.presentMainScreen()
       
    }
    
    func presentMainScreen(){
        
        //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //let mainVC = storyBoard.instantiateViewControllerWithIdentifier("MainVC") as! MainVC
        //self.presentViewController(mainVC, animated:true, completion:nil)
        
        // mainStoryboard
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        // rootViewController
        let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainVC") as? UIViewController
        
        // navigationController
        let navigationController = UINavigationController(rootViewController: rootViewController!)
        navigationController.isNavigationBarHidden = false // or not, your choice.
        self.present(navigationController, animated:true, completion:nil)
    }
}

