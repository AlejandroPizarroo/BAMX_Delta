//
//  LoginViewController.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 15/10/22.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    var isAccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInUser(_ sender: Any) {
        // perform segue
    }
    
    func verifyEmail(email: String) -> Bool{
            let emailRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
            
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            
            if emailPredicate.evaluate(with: textEmail.text!){
                return true
            }else{
                return false
            }
        }
    
    func displayAlertMessage(message:String){
        let alertController = UIAlertController(title: "Mensaje de la aplicación", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goMain"{
            if textEmail.text?.isEmpty == true || textPassword.text?.isEmpty == true{
                displayAlertMessage(message: "Favor de completar los campos de texto")
            }
            else{
                if verifyEmail(email: textEmail.text!){
                    let loginManager = FirebaseAuthManager()
                    
                    loginManager.logIn(email: textEmail.text!, password: textPassword.text!){ [weak self] (success) in
                        
                        guard let `self` = self else {return}
                        
                        if(success){
                            self.isAccess = true
                            UserDefaults.standard.set(self.textEmail.text!, forKey: "loggedUser")
                            UserDefaults.standard.synchronize()
                            self.performSegue(withIdentifier: "goMain", sender: nil)
                        }
                        else{
                            self.isAccess = false
                            self.displayAlertMessage(message: "Correo o contraseña incorrecta")
                        }
                    }
                }
                else{
                    displayAlertMessage(message: "El texto no es un email")
                    return false
                }
                                         
            }
        }else{
            self.performSegue(withIdentifier: "goRegister", sender: nil)
            return false
        }
        return isAccess
    }
    
        
}
    



