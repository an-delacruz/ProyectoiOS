//
//  Usuario.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 6/2/22.
//

import Foundation
struct UsuariosResponse:Codable {
    var ok:Bool
    var msg:String
    var results: [UsuarioStruct]
    
    enum CodingKeys: String, CodingKey{
        case ok = "ok"
        case msg = "msg"
        case results = "results"
    }
}
struct UsuarioResponse : Codable{
    var ok:Bool
    var msg: String
    var results: Usuario
    
    enum CodingKeys: String, CodingKey{
        case ok = "ok"
        case msg = "msg"
        case results = "results"
    }
}
struct CambiarContrasena:Codable{
    var actual:String
    var nueva:String
}
struct SeguirUsuario:Codable{
    let usuario:String
}
struct fotoUsuario:Codable {
    var img: String
}
