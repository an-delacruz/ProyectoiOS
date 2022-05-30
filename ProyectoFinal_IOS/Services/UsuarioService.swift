//
//  UsuarioService.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/29/22.
//

import Foundation



func getUsuarios(){
    let defaults = UserDefaults.standard
    let session = defaults.object(forKey: "auth") as? Auth
    let stringURL = baseURL + "/usuarios/"
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    //request.addValue(token, forHTTPHeaderField: "x-token")
    //request.allHTTPHeaderFields = ["x-token": session!.token]
    request.allHTTPHeaderFields = ["x-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c3VhcmlvIjp7ImlkVXN1YXJpbyI6MiwidXN1YXJpbyI6InBydWViYSIsIm5vbWJyZSI6ImN1ZW50YSIsImFwZWxsaWRvIjoicHJ1ZWJhIiwic3RhdHVzIjp0cnVlLCJjb250cmFzZW5hIjoiJDJiJDEwJFVLMFJoUkRDYk9ZM1lEbzhjQVdaT3VVQk1tLkJZZkxSSi9xNTJvQjR1NkFIeG1xbDRGa0Q2IiwiZm90byI6IiJ9LCJpYXQiOjE2NTM4ODM0MjQsImV4cCI6MTY1Mzk2OTgyNH0.GqwPxnCXe3TChq8XSHl_JOuUoAC6hoH-UTtWOAdjFoA"]
    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            guard let datos = data else {return}
            let dataJSON = try? JSONSerialization.jsonObject(with: datos, options:[])
            print(dataJSON)
            if let dataJSON = dataJSON as? [String:Any]{
                if dataJSON["ok"] as! Bool{
                    usuarios = dataJSON["results"] as! [Usuario]
                }

            }

        }
    }.resume()
}
func getUsuario(usuario:String){
    let defaults = UserDefaults.standard
    let session = defaults.object(forKey: "auth") as? Auth
    let stringURL = baseURL + "/usuarios/\(usuario)"
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    //request.addValue(token, forHTTPHeaderField: "x-token")
    request.allHTTPHeaderFields = ["x-token": session!.token]

    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            guard let datos = data else {return}
            let dataJSON = try? JSONSerialization.jsonObject(with: datos, options:[])
            if let dataJSON = dataJSON as? [String:Any]{
                if dataJSON["ok"] as! Bool{
                    print("msg -> \(dataJSON["results"]!)")
                }
            }

        }
    }.resume()
}
func postUsuario(_ usuario:Usuario){
    let defaults = UserDefaults.standard
    let session = defaults.object(forKey: "auth") as? Auth
    let stringURL = baseURL + "/usuarios/"
    let enconder = JSONEncoder()
    enconder.outputFormatting = .prettyPrinted
    let jsonData = try! enconder.encode(usuario)
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
