//
//  Usuario.swift
//  BAMX_Delta
//
//  Created by Alejandro Pizarro on 19/11/22.
//

import Foundation
import Firebase

struct Usuario{
    let ref: DatabaseReference?
    let key: String
    let nombre: String
    let apellido: String
    let telefono: String
    
    init(key: String, nombre: String, apellido: String, telefono: String){
        self.ref = nil
        self.key = key
        self.nombre = nombre
        self.apellido = apellido
        self.telefono = telefono
    }
    
    init?(snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String:AnyObject],
            let nombre = value["nombre"] as? String,
            let apellido = value["apellido"] as? String,
            let telefono  = value["telefono"] as? String
        else{
            return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.nombre = nombre
        self.apellido = apellido
        self.telefono = telefono
    }
    
    func toAnyObject()->Any {
        return[
            "nombre":nombre,
            "apellido":apellido,
            "telefono":telefono
        ]
    }
}
