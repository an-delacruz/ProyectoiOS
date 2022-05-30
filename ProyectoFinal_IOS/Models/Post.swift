//
//  Post.swift
//  ProyectoFinal_IOS
//
//  Created by Juan on 28/05/22.
//

import Foundation

class Post: Codable {
    var idPost, idUsuario: Int
    var usuario:String
    var img: String
    var publicacion: String
    var status: Bool
    var descripcion: String

    init(idPost: Int, idUsuario: Int, img: String, publicacion: String, status: Bool, descripcion: String, usuario:String) {
        self.idPost = idPost
        self.idUsuario = idUsuario
        self.img = img
        self.publicacion = publicacion
        self.status = status
        self.descripcion = descripcion
        self.usuario = usuario
    }
}

struct PostStruct:Codable{
    var idPost: Int
    var idUsuario: Int
    var usuario:String
    var img: String
    var publicacion: String
    var status: Bool
    var descripcion: String
}
var posts = [PostStruct]()
