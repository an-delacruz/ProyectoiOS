//
//  Perfil.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/31/22.
//

import Foundation

struct Perfil:Codable{
    var idUsuario: Int
    var nombre: String
    var apellido: String
    var usuario: String
    var status: Bool
    var foto: String
    var Posts: [PostStruct]
    var Seguidores: [Seguido]
    var seguidos: [Seguido]
}


