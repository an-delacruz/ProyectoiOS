//
//  ViewController.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/26/22.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox

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
        if(defaults.bool(forKey: "sonido")){
            AudioServicesPlaySystemSound(SystemSoundID(1000))
        }
        if(def?.token != nil){
            getRenovarToken(){
            json,error in
                if error == nil {
                    
                    self.redirigirSesionValida()
                } else {
                    self.alertaSesionExpirada()
                }
            }
           
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
            
            if error == nil {
                self.redirigirSesionValida()
            } else {
                self.AutenticacionInvalida(error!.msg)
            }
           
        }
        
        //getUsuarios()
        //print(usuarios)
        //postIniciarSesion(usuario: usuario, contrasena: contrasena


    }
   
    @IBAction func btnSign(_ sender: UIButton) {
        let vista = storyboard?.instantiateViewController(identifier: "viewSignUpID") as? viewSignUp
        self.navigationController?.present(vista!, animated: true, completion: nil)
    }
    
    func redirigirSesionValida(){
           let vista = storyboard?.instantiateViewController(identifier: "publicacionesEditable") as? viewPublicaciones
        
           vista?.modalPresentationStyle = .fullScreen
           self.navigationController?.present(vista!, animated: true, completion: nil)
       }
       
       func alertaSesionExpirada(){
           let dialogMessage = UIAlertController(title: "Sesion Expirada", message: "Parece que tu sesion expiro, vuelve a iniciar sesion y continua navegando.", preferredStyle: .alert)
           let cerrar = UIAlertAction(title: "Cerrar", style: .default)
           dialogMessage.addAction(cerrar)
           let defaults = UserDefaults.standard
           defaults.removeObject(forKey: "auth")
           self.present(dialogMessage, animated: true, completion: nil)
       }
       
       func AutenticacionInvalida(_ msg: String) {
           let dialogMessage = UIAlertController(title: "Inicio de sesion invalido", message: msg, preferredStyle: .alert)
           let cerrar = UIAlertAction(title: "Cerrar", style: .default)
           dialogMessage.addAction(cerrar)
           self.present(dialogMessage, animated: true, completion: nil)
       }

}
