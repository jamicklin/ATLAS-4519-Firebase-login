//
//  LoginViewController.swift
//  login tutorial
//
//  Created by Jacob Micklin on 4/11/16.
//  Copyright © 2016 Jacob Micklin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool)
    {
        //check to see if user is logged in//
        super.viewDidAppear(animated)
        
        //user is authenticated//
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && CURRENT_USER.authData != nil
        {
            //hide logout button//
            self.logoutButton.hidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginAction(sender: AnyObject)
    {
        //email + password from user//
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        //to make sure information is in the textfield//
        if email != "" && password != ""
        {
            
            //authenticate email and password through Firebase database//
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                
                //there was no error//
                if error == nil
                {
                   //saved to NSUserDefaults//
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    print("Logged In :)")
                    //logout button is now visible, once signed in//
                    self.logoutButton.hidden = false
                }
                //there was an error//
                else
                {
                    print(error)
                }
            })
            
        }
        //alert notification//
        else
        {
            //notifies user to enter email or password that's missing from the textfield//
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password.", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func logoutAction(sender: AnyObject)
    {
        //unauthorizes user from Firebase//
        CURRENT_USER.unauth()
        
        //no user is logged in//
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        //logged out user doesn't see logout button//
        self.logoutButton.hidden = true
        
    }
}














