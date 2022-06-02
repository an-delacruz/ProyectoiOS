//
//  AuthService.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/29/22.
//


import Foundation




func postIniciarSesion(usuario: String, contrasena: String, completion: @escaping(_ json: Any?, _ error: ErrorResponse?)-> ()) {
    let dict = ["usuario": usuario, "contrasena": contrasena]
    
    let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    
    let stringURL = baseURL + "/usuarios/auth/"
    //print(stringURL)
    guard let url = URL(string:stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    request.httpBody = jsonData
    
    URLSession.shared.dataTask(with: request)
    {
        (data,response,error) in
        DispatchQueue.main.async {
            do{
                let decoder = JSONDecoder();
                guard let res = response as? HTTPURLResponse else {return}
                
                guard let datos = data else {return}
                if  res.statusCode == 200 {
                    let auth = try decoder.decode(AuthResponse.self, from: datos).results
                    //print(auth)
                    let defaults = UserDefaults.standard
                    
                    defaults.setCustomObject(auth,forKey: "auth")
                    completion(auth,nil)
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

func getRenovarToken( completion: @escaping(_ json: Any?, _ error: ErrorResponse?)-> ()){
    let defaults = UserDefaults.standard
    let session = defaults.getCustomObject(dataType: Auth.self, key: "auth")

    let stringURL = baseURL + "/usuarios/auth/renew"
    guard let url = URL(string: stringURL) else {return}
    
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = ["x-token": session!.token, "Accept":"application/json"]
    print("actual token \(session!.token)")
    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            do{
                let decoder = JSONDecoder();
                guard let res = response as? HTTPURLResponse else {return}
                
                guard let datos = data else {return}
                if  res.statusCode == 200 {
                    let auth = try decoder.decode(AuthResponse.self, from: datos).results
                    //print(auth)
                    let defaults = UserDefaults.standard
                    
                    defaults.setCustomObject(auth,forKey: "auth")
                    completion(auth,nil)
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
