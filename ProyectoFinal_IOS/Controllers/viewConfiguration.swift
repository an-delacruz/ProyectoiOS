//
//  viewConfiguration.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/30/22.
//

import Foundation
import UIKit
import simd
import AVFAudio

class viewConfiguration:UIViewController{
    
    
    @IBOutlet weak var swSonido: UISwitch!
    
    let defaults = UserDefaults.standard
    var usuario : Usuario? ;

    @IBOutlet weak var swDarkMode: UISwitch!
    
    override func viewDidLoad() {
        self.swSonido.isOn = defaults.bool(forKey: "sonido")
    }
    
   
    @IBAction func configuracionSonido(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "sonido")
        defaults.synchronize()
    }
    
    @IBAction func btnSignOut(_ sender: UIButton) {
        let alerta = UIAlertController(title: "Confirmación", message: "Confirmar cierre de sesión", preferredStyle: .alert);
        let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        let btnAceptar = UIAlertAction(title: "Confirmar", style: .destructive){
            _ in
            self.defaults.removeObject(forKey: "auth")
            self.view?.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
        alerta.addAction(btnCancelar)
        alerta.addAction(btnAceptar)
        self.present(alerta, animated: true)

    }
    
    @IBAction func btnCambiarContrasena(_ sender: UIButton) {
        let alerta = UIAlertController(title: "Contrasena", message: "Cambiar contrasena", preferredStyle: .alert)
        
        
        alerta.addTextField(){
            (textField) -> Void in
            textField.placeholder = "Contrasena actual"
        }
        alerta.addTextField(){
            (textField) -> Void in
            textField.placeholder = "Contrasena nueva"
        }
        
        let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        let btnAceptar = UIAlertAction(title: "Guardar", style: .default){
            _ in
            self.obtenerUsuario(){
                res,error in
                let cambiarContrasena = CambiarContrasena(actual: alerta.textFields![0].text!, nueva: alerta.textFields![1].text!)
                let id = self.usuario?.idUsuario
                putContrasena(cambiarContrasena, id!){
                    json, error in
                    if error != nil {
                        self.dismiss(animated: true)

                        self.AlertaError(error!.msg)
                        return
                    }else{
                        self.AlertaConfirmacion((json as! BasicResponse).msg)
                        self.dismiss(animated: true)
                        return
                    }
                }
            }
        }
        alerta.addAction(btnCancelar)
        alerta.addAction(btnAceptar)
        self.present(alerta, animated: true)
        
    }
    func obtenerUsuario(completion:@escaping(_ res: Any, _ error: Any)->()){
        let user = defaults.getCustomObject(dataType: Auth.self, key: "auth")
        getUsuario(user!.usuario){
            json,error in
            if error != nil {
                self.AlertaError(error!.msg)
                return
            } else {
                self.usuario = json;
                
            }
            completion(json, error)
        }
    }
    
    func AlertaError(_ msg: String) {
        let dialogMessage = UIAlertController(title: "Error al obtener el usuario", message: msg, preferredStyle: .alert)
        let cerrar = UIAlertAction(title: "Cerrar", style: .default)
        dialogMessage.addAction(cerrar)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    func AlertaConfirmacion(_ msg:String){
        let dialog = UIAlertController(title:"Contrasena cambiada", message: msg, preferredStyle: .alert)
        let cerrar = UIAlertAction(title: "Cerrar", style: .default)
        dialog.addAction(cerrar)
        self.present(dialog, animated: true, completion: nil)
    }
    
}
