//
//  RegisterViewController.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 15/10/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

// text fields
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textApellido: UITextField!
    @IBOutlet weak var textPhone: UITextField!
    
// credentials
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    let ref = Database.database().reference(withPath: "Usuarios")
    
// MARK: Area de funciones

    func displayAlertMessage(message:String){
        let alertController = UIAlertController(title: "Mensaje de la aplicación", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
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
    
    @IBAction func saveUser(_ sender: Any) {
    
// MARK: Registrar usuario
        
        let key = UUID().uuidString
        let object : [String:Any] = [
            "nombre": self.textName.text!,
            "apellido": self.textApellido.text!,
            "telefono": self.textPhone.text!
        ]
        
        if textEmail.text?.isEmpty == true || textPassword.text?.isEmpty == true || textName.text?.isEmpty == true || textApellido.text?.isEmpty == true || textPhone.text?.isEmpty == true   {
            displayAlertMessage(message: "Tienes campos de texto vacíos")
        }else{
            if verifyEmail(email: textEmail.text!){
                let sgManager = FirebaseAuthManager()
                
                sgManager.createUser(email: textEmail.text!, password: textPassword.text!){
                    [weak self] (success) in
                    
                    var message = ""
                    
                    guard let `self` = self else {return}
                    
                    if success{
                        message = "El usuario se creó exitosamente!"
                    }else{
                        message = "Hubo un problema al crear el usuario"
                    }
                    
                    self.displayAlertMessage(message: message)
                }
            }else{
                self.displayAlertMessage(message: "El email es incorrecto!")
            }
            
        }
        
        ref.child(key).setValue(object){
            (error: Error?, ref:DatabaseReference) in
                    
            var message = ""
                    
            if let error = error {
                message = "Ha ocurrido un error"
                        print(error)
            }
            else{
                message = "El usuario se creó exitosamente!"
            }
                
            let alertController = UIAlertController(title: "Mensaje de la aplición ", message: message, preferredStyle: .alert)
                    
            let OKAction = UIAlertAction(title: "OK", style: .default)
                {(action: UIAlertAction!) in
                    print ("OK was pressed")
                    }
                    
            alertController.addAction(OKAction)
                    
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
}
    

