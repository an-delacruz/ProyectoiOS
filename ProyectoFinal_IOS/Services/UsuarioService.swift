//
//  UsuarioService.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/29/22.
//

import Foundation


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


func getUsuario(_ usuario:String,completion: @escaping (_ json: Usuario?, _ error: ErrorResponse?)->()){
    let defaults = UserDefaults.standard
    let session = defaults.getCustomObject(dataType: Auth.self, key: "auth")
    let stringURL = baseURL + "/usuarios/\(usuario)"
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = ["x-token": session!.token]

    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            do{
                
                let decoder = JSONDecoder();
                guard let res = response as? HTTPURLResponse else {return}
                //print("res -› \(res)")
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
                //print("res -› \(res)")
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

func putUsuario(_ usuario:PutUsuarioStruct,completion: @escaping(_ json: Any?, _ error: ErrorResponse?)-> ()){
    let defaults = UserDefaults.standard
    let auth = defaults.getCustomObject(dataType: Auth.self, key: "auth")
    let stringURL = baseURL + "/usuarios/\(auth!.usuario)"
    let enconder = JSONEncoder()
    enconder.outputFormatting = .prettyPrinted
    let jsonData = try! enconder.encode(usuario)
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.allHTTPHeaderFields = [
        "Content-Type": "application/json",
        "Accept": "application/json",
        "x-token": auth?.token ?? ""
    ]
    request.httpBody = jsonData

    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            do{
                
                let decoder = JSONDecoder();
                guard let res = response as? HTTPURLResponse else {return}
                //print("res -› \(res)")
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

func putContrasena(_ cambiarContrasena:CambiarContrasena, _ id:Int, completion: @escaping(_ json:Any?, _ error:ErrorResponse?)->()){
    //print(cambiarContrasena)
    let defaults = UserDefaults.standard
    let session = defaults.getCustomObject(dataType: Auth.self, key: "auth")
    let stringURL = baseURL + "/usuarios/contrasena/\(id)"
    //print(stringURL	)
    let enconder = JSONEncoder()
    enconder.outputFormatting = .prettyPrinted
    let jsonData = try! enconder.encode(cambiarContrasena)
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.httpBody = jsonData
    request.allHTTPHeaderFields = ["x-token": session!.token]
    request.allHTTPHeaderFields = [
        "Content-Type": "application/json",
        "Accept": "application/json"]
    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            do{
                let decoder = JSONDecoder();
                guard let res = response as? HTTPURLResponse else {return}
                guard let datos = data else {return}
                if  res.statusCode == 200 {
                    let cambioContrasena = try decoder.decode(BasicResponse.self,from:datos)
                    completion(cambioContrasena,nil)
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
