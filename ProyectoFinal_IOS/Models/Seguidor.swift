//
//  Seguidor.swift
//  ProyectoFinal_IOS
//
//  Created by Juan on 28/05/22.
//

import Foundation
class Seguido: Codable {
    var usuario, nombre, apellido: String
    var idUsuarioSeguido: Int?

    init(usuario: String, nombre: String, apellido: String, idUsuarioSeguido: Int?) {
        self.usuario = usuario
        self.nombre = nombre
        self.apellido = apellido
        self.idUsuarioSeguido = idUsuarioSeguido
    }
}
