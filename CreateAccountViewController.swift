//
//  CreateAccountViewController.swift
//  login tutorial
//
//  Created by Jacob Micklin on 4/11/16.
//  Copyright © 2016 Jacob Micklin. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func createAccountAction(sender: AnyObject)
    {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
       //check to make sure email or password is not blank//
        if email != "" && password != ""
        {
                FIREBASE_REF.createUser(email, password: password, withValueCompletionBlock: { (error, result) -> Void in
                    
                    if error == nil
                    {
                       FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                    
                        if error == nil
                        {
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            print("Account Created :)")
                            
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                        else
                        {
                            print(error)
                        }
                       })
                    }
                    else
                    {
                       print(error)
                    }
                
                })
        }
        else
        {
            //alerts if email or password is blank//
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    @IBAction func cancelAction(sender: AnyObject)
    {
    self.dismissViewControllerAnimated(true, completion: nil)
    }
}








