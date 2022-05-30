//
//  Usuario.swift
//  ProyectoFinal_IOS
//
//  Created by Juan on 28/05/22.
//

import Foundation


class Usuario:Codable {
var idUsuario: Int
    var nombre, apellido, usuario: String
    var status: Bool
    var foto: String
    var posts: [Post]
    var seguidores, seguidos: [Seguido]

    enum CodingKeys: String, CodingKey {
        case idUsuario, nombre, apellido, usuario, status, foto
        case posts = "Posts"
        case seguidores = "Seguidores"
        case seguidos
    }

    init(idUsuario: Int, nombre: String, apellido: String, usuario: String, status: Bool, foto: String, posts: [Post], seguidores: [Seguido], seguidos: [Seguido]) {
        self.idUsuario = idUsuario
        self.nombre = nombre
        self.apellido = apellido
        self.usuario = usuario
        self.status = status
        self.foto = foto
        self.posts = posts
        self.seguidores = seguidores
        self.seguidos = seguidos
    }
}


var usuarios = [Usuario]()

struct Auth:Decodable, Encodable {
    var usuario: String
    var token: String
}
struct Seguir: Decodable,Encodable
{
    var idUsuarioSeguido: Int
    var idSeguidor: Int
    var idSeguido: Int
    var fechaSeguimiento: String
    var status: Bool
}
