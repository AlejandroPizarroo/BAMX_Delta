//
//  FirebaseAuthManager.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 07/11/22.
//

import FirebaseAuth

class FirebaseAuthManager{
    
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) {
            
            (authResult, error) in
            
            if let user = authResult?.user{
                print(user)
                completionBlock(true)
            }else{
                completionBlock(false)
            }
        }
    }
    
    func logIn(email:String, password: String, completionBlock: @escaping (_ success: Bool) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password){
            (authResult, error) in
            if let user = authResult?.user{
                print(user)
                completionBlock(true)
            }else{
                completionBlock(false)
            }
        }
    }
    
}
