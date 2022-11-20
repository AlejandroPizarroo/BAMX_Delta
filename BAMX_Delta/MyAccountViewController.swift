//
//  MyAccountViewController.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 15/11/22.
//

import Foundation
import UIKit

class MyAccountViewController: UIViewController {


    @IBOutlet weak var logOut: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logOut.layer.cornerRadius = 10
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
