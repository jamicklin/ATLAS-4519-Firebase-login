//
//  BaseService.swift
//  login tutorial
//
//  Created by Jacob Micklin on 4/11/16.
//  Copyright © 2016 Jacob Micklin. All rights reserved.
//

import Foundation
import Firebase

//reference to URL//
let BASE_URL = "https://login-tutorial-jmicklin.firebaseio.com"

//reference to database//
let FIREBASE_REF = Firebase(url: BASE_URL)

//reference to user that's currently logged in//
var CURRENT_USER: Firebase
{
 //obtain unique identifier//
 let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    
 //get user from the database//
 let currentUser = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    
    //return it to xcode to be stored in var CURRENT_USER: Firebase//
    return currentUser!
}



