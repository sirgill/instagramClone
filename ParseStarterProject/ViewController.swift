/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupMode = true
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    
    
    }

    @IBAction func signupOrLogin(_ sender: AnyObject) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            createAlert(title: "Ops", message: "Please enter an email or password")
        }
        else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signupMode {
                //Sign up
                
                let user = PFUser()
                
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try agian later."
                        
                        if let errorMessage = (error! as NSError).userInfo["error"] as? String{
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        self.createAlert(title: "Ops", message: displayErrorMessage)
                    } else {
                        
                        print("Welcome to Instagram Clone")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                })
            } else {
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try agian later."
                        
                        if let errorMessage = (error! as NSError).userInfo["error"] as? String{
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title: "Ops", message: displayErrorMessage)
                        
                        
                    } else {
                        
                        print("Logged In")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                })
            }
            
        }
        
        
        
    }
    
    @IBOutlet weak var signupOrLogin: UIButton!
    
    @IBAction func changeSignupMode(_ sender: Any) {
        
        if signupMode {
            //change to login mode
            
            signupOrLogin.setTitle("Log In", for: [])
            
            changeSignupModeButton.setTitle("Sign Up", for: [])
            
            messageLabel.text = "Don't have an account?"
            
            signupMode = false
            
        } else {
            //change to sign up mode
            
            signupOrLogin.setTitle("Sign Up", for: [])
            
            changeSignupModeButton.setTitle("Log In", for: [])
            
            messageLabel.text = "Already have an account?"
            
            signupMode = true
        }
        
        
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var changeSignupModeButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current()?.objectId != nil {
            
           performSegue(withIdentifier: "showUserTable", sender: self)
       }
        
        self.navigationController?.navigationBar.isHidden = true
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
