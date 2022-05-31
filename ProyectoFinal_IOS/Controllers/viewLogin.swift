//
//  ViewController.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/26/22.
//

import Foundation
import UIKit

class viewLogin:UIViewController
{
    @IBOutlet weak var lblUsername: UILabel!
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblSignUp: UILabel!
    
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        let def = defaults.getCustomObject(dataType: Auth.self, key: "auth")
        if(def?.token != nil){
            getRenovarToken()
            let vista = storyboard?.instantiateViewController(identifier: "publicacionesEditable") as? viewPublicaciones
            vista?.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vista!, animated: true, completion: nil)
        }
    }
    @IBAction func btnSignUp(_ sender: Any) {
     
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let usuario = txtUsername.text!
        let contrasena = txtPassword.text!
        let group = DispatchGroup()
        group.enter()
        postIniciarSesion(usuario: usuario, contrasena: contrasena){
            json, error in
            let vista = self.storyboard?.instantiateViewController(identifier: "publicacionesEditable") as? viewPublicaciones
            vista?.modalPresentationStyle = .fullScreen

            self.navigationController?.present(vista!, animated: true, completion: nil)
        }
        
        //getUsuarios()
        //print(usuarios)
        //postIniciarSesion(usuario: usuario, contrasena: contrasena


    }
    func redirigirLogin(){

        print("Redirigir login")

    }
    @IBAction func btnSign(_ sender: UIButton) {
        let vista = storyboard?.instantiateViewController(identifier: "viewSignUpID") as? viewSignUp
        self.navigationController?.present(vista!, animated: true, completion: nil)
    }
}
