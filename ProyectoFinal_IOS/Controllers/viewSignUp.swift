//
//  viewSignUp.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/26/22.
//

import Foundation
import UIKit

class viewSignUp:UIViewController{
    
    
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    
    @IBOutlet weak var btnSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickSignUp(_ sender: UIButton) {
        let usuario = txtUsuario.text!
        let nombre = txtNombre.text!
        let apellido = txtApellido.text!
        let contrasena = txtContrasena.text!
        
        let user = PostUsuarioStruct(nombre: nombre, apellido: apellido, usuario: usuario, contrasena: contrasena)
       
        postUsuario(user){
            json,error in
           if error == nil {
                self.Alerta("Info", (json! as! BasicResponse).msg){
                    self.redirigirLogin()
                }
            } else {
               
                self.Alerta("Error al crear al usuario", error!.msg){}

            }
        }
    }
    
    func redirigirLogin(){
        let vista = storyboard?.instantiateViewController(identifier: "viewLoginID") as? viewLogin
        self.dismiss(animated: true)
    }
    func Alerta(_ title: String,_ msg: String, completion: @escaping()-> ()) {
        let dialogMessage = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cerrar = UIAlertAction(title: "Cerrar", style: .default){_ in 
            completion()
        }
        dialogMessage.addAction(cerrar)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
}
