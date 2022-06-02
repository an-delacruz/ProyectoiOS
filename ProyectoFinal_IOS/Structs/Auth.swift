//
//  Auth.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 6/2/22.
//

import Foundation
struct AuthResponse:Codable {
    var ok:Bool
    var msg: String
    var results: Auth
    
    enum CodingKeys: String, CodingKey{
        case ok = "ok"
        case msg = "msg"
        case results = "results"
    }
}
struct IniciarSesion:Codable {
    var usuario : String
    var contrasena: String
    
    init(_ usr :String, _ contrasena: String){
        self.usuario = usr
        self.contrasena = contrasena
    }
}
