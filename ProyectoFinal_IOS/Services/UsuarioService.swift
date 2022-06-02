//
//  UsuarioService.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/29/22.
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
func getUsuarios(completion:@escaping(_ json:Any?, _ error:ErrorResponse?)->()){
    let defaults = UserDefaults.standard
    let def = defaults.getCustomObject(dataType: Auth.self, key: "auth")
    let stringURL = baseURL + "/usuarios/"
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = ["x-token": def!.token]

    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            do{
                guard let datos = data else {return}
                let decoder = JSONDecoder()
                guard let res = response as? HTTPURLResponse else {return}
                if res.statusCode == 200{
                    let body = try decoder.decode(UsuariosResponse.self, from: datos).results
                    completion(body, nil)
                }else{
                    let err = try decoder.decode(ErrorResponse.self,from:datos)
                    completion(nil,err)
                }
            }
            catch let jsonError{
                print(jsonError)
            }

            

        }
    }.resume()
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
func getUsuario(_ usuario:String,completion: @escaping (_ json: Usuario?, _ error: ErrorResponse?)->()){
    let defaults = UserDefaults.standard
    let session = defaults.getCustomObject(dataType: Auth.self, key: "auth")
    let stringURL = baseURL + "/usuarios/\(usuario)"
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    //request.addValue(token, forHTTPHeaderField: "x-token")
    request.allHTTPHeaderFields = ["x-token": session!.token]

    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            do{
                
                let decoder = JSONDecoder();
                guard let res = response as? HTTPURLResponse else {return}
                print("res -› \(res)")
                guard let datos = data else {return}
                if  res.statusCode == 200 {
                    let usuario = try decoder.decode(UsuarioResponse.self,from:datos).results
                    completion(usuario,nil)
                    return
                    
                } else  {
                    let err = try decoder.decode(ErrorResponse.self, from: datos)
                    print(err)
                    completion(nil,err)
                    return
                }
                
            }
            catch let jsonError{
                print(jsonError)
            }

        }
    }.resume()
}
func postUsuario(_ usuario:PostUsuarioStruct,completion: @escaping(_ json: Any?, _ error: ErrorResponse?)-> ()){
    let stringURL = baseURL + "/usuarios/"
    let enconder = JSONEncoder()
    enconder.outputFormatting = .prettyPrinted
    let jsonData = try! enconder.encode(usuario)
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    request.httpBody = jsonData

    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            do{
                
                let decoder = JSONDecoder();
                guard let res = response as? HTTPURLResponse else {return}
                print("res -› \(res)")
                guard let datos = data else {return}
                if  res.statusCode == 200 {
                    let body = try decoder.decode(BasicResponse.self, from: datos)
                    completion(body,nil)
                    return
                    
                } else  {
                    let err = try decoder.decode(ErrorResponse.self, from: datos)
                    print(err)
                    completion(nil,err)
                    return
                }
                
            }
            catch let jsonError{
                print(jsonError)
            }
        }
    }.resume()

}
func putUsuario(_ usuario:Usuario){
    let defaults = UserDefaults.standard
    let session = defaults.object(forKey: "auth") as? Auth
    let stringURL = baseURL + "/usuarios/\(usuario.idUsuario)"
    let enconder = JSONEncoder()
    enconder.outputFormatting = .prettyPrinted
    let jsonData = try! enconder.encode(usuario)
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.httpBody = jsonData
    //request.addValue(token, forHTTPHeaderField: "x-token")
    request.allHTTPHeaderFields = ["x-token": session!.token]

    print("body -> \(request.httpBody?.prettyPrintedJSONString!)")
    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            guard let datos = data else {return}
            let dataJSON = try? JSONSerialization.jsonObject(with: datos, options:[])
            if let dataJSON = dataJSON as? [String:Any]{
                if dataJSON["ok"] as! Bool{
                    print("msg -> \(dataJSON["msg"]!)")
                }
            }

        }
    }.resume()
}

func deleteUsuario(_ id:Int){
    let defaults = UserDefaults.standard
    let session = defaults.object(forKey: "auth") as? Auth
    let stringURL = baseURL + "/usuarios/\(id)"
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    //request.addValue(token, forHTTPHeaderField: "x-token")
    request.allHTTPHeaderFields = ["x-token": session!.token]

    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            guard let datos = data else {return}
            let dataJSON = try? JSONSerialization.jsonObject(with: datos, options:[])
            if let dataJSON = dataJSON as? [String:Any]{
                if dataJSON["ok"] as! Bool{
                    print("msg -> \(dataJSON["msg"]!)")
                }
            }

        }
    }.resume()
}

struct CambiarContrasena:Encodable{
    var actual:String
    var nueva:String
}

func putContrasena(_ usuario:CambiarContrasena, _ id:Int){
    let defaults = UserDefaults.standard
    let session = defaults.object(forKey: "auth") as? Auth
    let stringURL = baseURL + "/usuarios/contrasena/\(id)"
    let enconder = JSONEncoder()
    enconder.outputFormatting = .prettyPrinted
    let jsonData = try! enconder.encode(usuario)
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.httpBody = jsonData
    //request.addValue(token, forHTTPHeaderField: "x-token")
    request.allHTTPHeaderFields = ["x-token": session!.token]

    print("body -> \(request.httpBody?.prettyPrintedJSONString!)")
    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            guard let datos = data else {return}
            let dataJSON = try? JSONSerialization.jsonObject(with: datos, options:[])
            if let dataJSON = dataJSON as? [String:Any]{
                if dataJSON["ok"] as! Bool{
                    print("msg -> \(dataJSON["msg"]!)")
                }
            }

        }
    }.resume()
}

func postFoto(_ img:String){
    let defaults = UserDefaults.standard
    let session = defaults.object(forKey: "auth") as? Auth
    let stringURL = baseURL + "/usuarios/foto"
    let enconder = JSONEncoder()
    enconder.outputFormatting = .prettyPrinted
    let jsonData = try! enconder.encode(img)
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = jsonData
    //request.addValue(token, forHTTPHeaderField: "x-token")
    request.allHTTPHeaderFields = ["x-token": session!.token]

    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            guard let datos = data else {return}
            let dataJSON = try? JSONSerialization.jsonObject(with: datos, options:[])
            if let dataJSON = dataJSON as? [String:Any]{
                if dataJSON["ok"] as! Bool{
                    
                }
            }

        }
    }.resume()
}

struct SeguirUsuario:Codable{
    let usuario:String
}
func postSeguirUsuario(_ usuario:SeguirUsuario, completion:@escaping(_ json: Any?, _ error:ErrorResponse?)->()){
    let defaults = UserDefaults.standard
    let def = defaults.getCustomObject(dataType: Auth.self, key: "auth")
    let stringURL = baseURL + "/seguidores/nuevo"
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let jsonData = try! encoder.encode(usuario)
    guard let url = URL(string:stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    request.allHTTPHeaderFields = ["x-token": def!.token]
    request.httpBody = jsonData
    
    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            do{
                
                let decoder = JSONDecoder();
                guard let res = response as? HTTPURLResponse else {return}
                guard let datos = data else {return}
                if  res.statusCode == 200 {
                    let body = try decoder.decode(BasicResponse.self, from: datos)
                    completion(body,nil)
                    return
                    
                } else  {
                    let err = try decoder.decode(ErrorResponse.self, from: datos)
                    completion(nil,err)
                    return
                }
                
            }
            catch let jsonError{
                print(jsonError)
            }
        }
    }.resume()
}

struct fotoUsuario:Codable {
var img: String
}
func postSubirFoto(_ img:String,  completion:@escaping(_ json: Any?, _ error:ErrorResponse?)->()){
    let defaults = UserDefaults.standard
    let def = defaults.getCustomObject(dataType: Auth.self, key: "auth")
    let stringURL = baseURL + "/usuarios/foto"
    let data = fotoUsuario(img: img)
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let jsonData = try! encoder.encode(data)
    guard let url = URL(string:stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    request.allHTTPHeaderFields = ["x-token": def!.token]
    request.httpBody = jsonData
    
    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            do{
                
                let decoder = JSONDecoder();
                guard let res = response as? HTTPURLResponse else {return}
                guard let datos = data else {return}
                if  res.statusCode == 200 {
                    let body = try decoder.decode(BasicResponse.self, from: datos)
                    completion(body,nil)
                    return
                    
                } else  {
                    let err = try decoder.decode(ErrorResponse.self, from: datos)
                    completion(nil,err)
                    return
                }
                
            }
            catch let jsonError{
                print(jsonError)
            }
        }
    }.resume()
}
