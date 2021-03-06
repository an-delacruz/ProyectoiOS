//
//  PublicacionService.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/29/22.
//

import Foundation
import UIKit

var baseURL = "https://ios-backend-tec.herokuapp.com"


func getPublicaciones(completion: @escaping (_ json: Any?, _ error: Any?)->())
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
                //print("post -> \(posts)")
                posts.reverse()
                completion(posts, error)
            }
            catch{
                print("Error\(error)")
            }
    }
}.resume()
}

func postPublicacion(_ post:PublicacionPost, completion: @escaping(_ json:Any?,_ error:ErrorResponse?)->()){
    let defaults = UserDefaults.standard
    let session = defaults.getCustomObject(dataType: Auth.self, key: "auth")
    let stringURL = baseURL + "/posts/"
    
    //let enconder = JSONEncoder()
    //enconder.outputFormatting = .prettyPrinted
    //let jsonData = try! enconder.encode(post)
    let jsonData = try! JSONEncoder().encode(post)
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
func deletePublicacion(_ id: Int, completion: @escaping(_ json:Any?, _ error:Error?)->()) {
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
            completion(dataJSON, error)
        }
    }.resume()
}
