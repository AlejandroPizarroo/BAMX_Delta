//
//  AboutUsViewController.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 14/11/22.
//

import youtube_ios_player_helper
import Foundation
import UIKit
import Firebase
import FirebaseAuth

class AboutUsViewController: UIViewController{
    
    @IBOutlet var playerView : YTPlayerView!

    @IBOutlet weak var aboutUs: UIButton!
    @IBOutlet weak var campaigns: UIButton!
    @IBOutlet weak var donations: UIButton!
    @IBOutlet weak var myAccount: UIButton!
    
    let ref = Database.database().reference(withPath: "Usuarios")
    var items: [Usuario] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let value = UserDefaults.standard.string(forKey: "loggedUser"){
            ref.observe(.value, with:{ snapshot in print(snapshot.value as Any)
                
            })
            
            ref.observe(.value, with:{ snapshot in var newUser: [Usuario] = []
                for child in snapshot.children{
                    if let snapshot = child as? DataSnapshot,
                       let usuarios = Usuario(snapshot: snapshot){
                        newUser.append(usuarios)
                    }
                }
                self.items = newUser
            })
            
            displayMessage(message: "El usuario " + value + " ha iniciado sesión (viewDidLoad)")
        }
        playerView.load(withVideoId: "VUQ5VYnNdGM") // ID del video que queremos mostrar
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let value = UserDefaults.standard.string(forKey: "loggedUser"){
            print(value + "ha iniciado sesión")
            //displayMessage(message: "El usuario " + value + " ha iniciado sesión (viewDidAppear)")
        }
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.performSegue(withIdentifier: "myAccount", sender: nil)
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

    func displayMessage(message: String){
        let alert = UIAlertController(title: "Mensaje de la aplicacion", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }


}
