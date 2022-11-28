//
//  VolunteerViewController.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 24/11/22.
//

import Foundation
import UIKit
import Firebase

class VolunteerViewController: UIViewController {
    
    
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textMessage: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let ref = Database.database().reference(withPath: "Voluntarios")
    
    override func viewDidLoad() {
        registerButton.layer.cornerRadius = 10
        super.viewDidLoad()
    }
    
    // MARK: Area de funciones
    
    func verifyEmail(email: String) -> Bool{
        let emailRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if emailPredicate.evaluate(with: textEmail.text!)
        {
            return true
        }
        else{
            return false
        }
    }
    
    func displayAlertMessage(message:String){
        let alertController = UIAlertController(title: "Mensaje de la aplicación", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayAlertMessageBlank(message:String){
        let alertController = UIAlertController(title: "Mensaje de la aplicación", message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Registrar voluntario
    
    @IBAction func registerVolunteer(_ sender: Any) {
        
        let key = UUID().uuidString
        let object : [String:Any] = [
            "contacto" : self.textEmail.text!,
            "mensaje" : self.textMessage.text!
        ]
        
        if textEmail.text?.isEmpty == true || textMessage.text?.isEmpty == true{
            displayAlertMessage(message: "Tienes campos de texto vacíos")
        }else{
            if verifyEmail(email: textEmail.text!){
                ref.child(key).setValue(object){
                    (error: Error?, ref:DatabaseReference) in
                    
                    var message = ""
                    
                    if let error = error {
                        message = "Ha ocurrido un error"
                        print(error)
                    }
                    else{
                        message = "Voluntariado registrado exitosamente!"
                    }
                    self.displayAlertMessageBlank(message: message)
                }
                
            }
        }
        
    }
}
