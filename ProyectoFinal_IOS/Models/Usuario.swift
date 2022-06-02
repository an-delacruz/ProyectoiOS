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
        case idUsuario, nombre, apellido, status, foto
        case usuario = "usuario"
        case posts = "Posts"
        case seguidores = "Seguidores"
        case seguidos = "Seguidos"
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
struct UsuarioStruct: Codable {
    let idUsuario: Int
    let nombre, apellido, usuario: String
    let status: Bool
    let foto: String
    let posts: [PublicacionUsuarioStruct]
    let seguidores, seguidos: [SeguidorUsuarioStruct]
    let seguido: Bool

    enum CodingKeys: String, CodingKey {
        case idUsuario, nombre, apellido, usuario, status, foto
        case posts = "Posts"
        case seguidores = "Seguidores"
        case seguidos = "Seguidos"
        case seguido
    }
}
struct PublicacionUsuarioStruct:Codable{
    let idPost, idUsuario: Int
    let img: String
    let publicacion: String
    let status: Bool
    let descripcion: String
}
struct SeguidorUsuarioStruct:Codable{
    let usuario, nombre, apellido:String
    let idUsuarioSeguido:Int?
}
struct PostUsuarioStruct: Codable {
    var nombre, apellido, usuario, contrasena: String
}


var usuarios = [UsuarioStruct]()

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
