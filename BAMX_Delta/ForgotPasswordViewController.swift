//
//  ForgotPasswordViewController.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 27/11/22.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController{
    
    
    @IBOutlet weak var emailField: UITextField!
    
    func displayAlertMessage(message:String){
        let alertController = UIAlertController(title: "Mensaje de la aplicación", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    @IBAction func forgotPassButton_Tapped(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: emailField.text!) {(error) in
            if error == nil {
                self.displayAlertMessage(message: "Correo para restablecer contraseña enviado exitosamente!")
            }else{
                self.displayAlertMessage(message: "FAILED - \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
}
