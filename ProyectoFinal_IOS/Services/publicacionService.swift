//
//  PublicacionService.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/29/22.
//

import Foundation

var baseURL = "https://ios-backend-tec.herokuapp.com"

struct PublicacionResponse:Codable {
    var ok:Bool
    var results: [PostStruct]
    
    enum CodingKeys: String, CodingKey{
        case ok = "ok"
        case results = "results"
    }
}
func getPublicaciones()
{
    let defaults = UserDefaults.standard
    let def = defaults.getCustomObject(dataType: Auth.self, key: "auth")
    let stringURL = baseURL + "/posts/"
    guard let url = URL(string:stringURL) else {return}
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    //request.addValue(token, forHTTPHeaderField: "x-token")
    print("token -> \(def?.token)")
    request.allHTTPHeaderFields = ["x-token": def!.token]

    URLSession.shared.dataTask(with: request)
    {
        (data,response,error) in
        DispatchQueue.main.async {
            guard let datos = data else {return}
            do{
                let decoder = JSONDecoder()
                posts = try decoder.decode(PublicacionResponse.self,from:datos).results
                print("post -> \(posts)")
                posts.forEach{ post in
                    print("Post -> \(post)")
                    let tableView = viewPublicaciones();                    tableView.reloadData()
                }
            }
            catch{
                print("Error\(error)")
            }
    }
}.resume()
}

func postPublicacion(_ post:Post){
    let defaults = UserDefaults.standard
    let session = defaults.object(forKey: "auth") as? Auth
    let stringURL = baseURL + "/posts/"
    
    //let enconder = JSONEncoder()
    //enconder.outputFormatting = .prettyPrinted
    //let jsonData = try! enconder.encode(post)
    let jsonData = try! JSONSerialization.data(withJSONObject: post, options: .prettyPrinted)
    guard let url = URL(string: stringURL) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = jsonData
    //request.addValue(token, forHTTPHeaderField: "x-token")
    request.allHTTPHeaderFields = ["x-token": session!.token]
    request.allHTTPHeaderFields = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    URLSession.shared.dataTask(with:request){
        (data,response,error) in
        DispatchQueue.main.async {
            guard let datos = data else {return}
            let dataJSON = try? JSONSerialization.jsonObject(with: datos, options:[])
            if let dataJSON = dataJSON as? [String:Any]{
                if dataJSON["ok"] as! Bool{
                    print(dataJSON);
                }
            }

        }
    }.resume()
}
func deletePublicacion(_ id: Int) {
    let defaults = UserDefaults.standard
    let session = defaults.object(forKey: "auth") as? Auth
    let stringURL = baseURL + "/posts/\(id)"
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
