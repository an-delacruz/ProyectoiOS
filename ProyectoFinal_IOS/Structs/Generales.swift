//
//  Generales.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 6/2/22.
//

import Foundation
struct ErrorResponse:Codable {
    var ok:Bool
    var msg: String
    
    enum CodingKeys: String, CodingKey{
        case ok = "ok"
        case msg = "msg"
    }
}
struct BasicResponse:Codable {
    var ok:Bool
    var msg: String
    
    enum CodingKeys: String, CodingKey{
        case ok = "ok"
        case msg = "msg"
    }
}
