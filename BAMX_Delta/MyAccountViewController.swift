//
//  MyAccountViewController.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 15/11/22.
//

import Firebase
import FirebaseAuth
import Foundation
import UIKit

extension UserDefaults{
    @NSManaged var nombre: String
}

class MyAccountViewController: UIViewController{


    @IBOutlet weak var logOut: UIButton!
    
    @IBOutlet weak var currentUserLabel: UILabel!
    
    var udObservation: NSKeyValueObservation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logOut.layer.cornerRadius = 10
        
        let ud = UserDefaults.standard
        currentUserLabel.text = String(ud.string(forKey: "nombre") ?? "nil")
        udObservation = ud.observe(\.nombre, options: .new) {ud, change in
            if let newValue = change.newValue{
                self.currentUserLabel.text = String(newValue)
            }
        }
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let value = UserDefaults.standard.string(forKey: "loggedUser"){
            print(value + " is still logged in")
        }
        else{
            var waitAlert: UIAlertController
            var indicator: UIActivityIndicatorView
            waitAlert = UIAlertController(title: "Un momento...", message: nil, preferredStyle: .alert)
            indicator = UIActivityIndicatorView(frame: waitAlert.view.bounds)
            indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            waitAlert.view.addSubview(indicator)
            
            self.present(waitAlert, animated: true, completion: nil)
            
            print("No User Default Available")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                waitAlert.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "logOut", sender: nil)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch segue.identifier{
        case "logOut":
            if let value = UserDefaults.standard.string(forKey: "loggedUser"){
                DispatchQueue.main.async(execute: {
                    UserDefaults.standard.removeObject(forKey: "loggedUser")
                    UserDefaults.standard.synchronize()
                })
                print(value + " has logged out")
            }
        break
            
        default: break
            
        }
    
    }
    
}
