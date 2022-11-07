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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveUser(_ sender: Any) {
        
        let key = self.textName.text!
        let object : [String:Any] = [
            "nombre": self.textName.text!,
            "apellido": self.textApellido.text!,
            "telefono": self.textPhone.text!
        ]
        
        // agregar usuarios a firebase
        ref.child(key).setValue(object){
            (error: Error?, ref:DatabaseReference) in
                    
            var message = ""
                    
            if let error = error {
                message = "Ha ocurrido un error"
                        print(error)
            }
            else{
                message = "El usuario se agregó exitosamente!"
            }
                
            let alertController = UIAlertController(title: "Mensaje de la aplición", message: message, preferredStyle: .alert)
                    
            let OKAction = UIAlertAction(title: "OK", style: .default)
                {(action: UIAlertAction!) in
                    print ("OK was pressed")
                    }
                    
            alertController.addAction(OKAction)
                    
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
    

