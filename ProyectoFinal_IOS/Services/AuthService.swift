//
//  AuthService.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/29/22.
//


import Foundation


struct AuthResponse:Codable {
    var ok:Bool
    var msg: String
    var results: Auth
    
    enum CodingKeys: String, CodingKey{
        case ok = "ok"
        case msg = "msg"
        case results = "results"
    }
}
struct IniciarSesion:Codable {
    var usuario : String
    var contrasena: String
    
    init(_ usr :String, _ contrasena: String){
        self.usuario = usr
        self.contrasena = contrasena
    }
}

func postIniciarSesion(usuario: String, contrasena: String) {
    let dict = ["usuario": usuario, "contrasena": contrasena]

    let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    
    let stringURL = baseURL + "/usuarios/auth/"
    print(stringURL)
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
            guard let datos = data else {
                return
            }
            do {
                let decoder = JSONDecoder();
                
                let auth = try decoder.decode(AuthResponse.self, from: datos).results
                print(auth)
               let defaults = UserDefaults.standard
                
                defaults.setCustomObject(auth,forKey: "auth")
                
                let def = defaults.getCustomObject(dataType: Auth.self, key: "auth")
                print("token \(def!.token)")
            }
            catch let jsonError{
                print(jsonError)
            }
        }
    }.resume()
}

func getRenovarToken(){
    let defaults = UserDefaults.standard
    guard let session = defaults.object(forKey: "auth") as? Auth else {return}

    let stringURL = baseURL + "/auth/renew"
    guard let url = URL(string: stringURL) else {return}

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = ["x-token": session.token]

    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            guard let datos = data else {return}
            do{
                let dataJSON = try? JSONSerialization.jsonObject(with: datos, options: [])
                if let dataJSON = dataJSON as? [String:Any]{
                    if dataJSON["ok"] as! Bool{
                        let auth:Auth = dataJSON["results"]! as! Auth
                        let defaults = UserDefaults.standard
                        defaults.set(auth,forKey: "auth")
                    }
                }

            }
            catch let jsonError {
                print(jsonError)
            }
        }
    }.resume()
}
