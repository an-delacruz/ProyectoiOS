//
//  viewSubirFoto.swift
//  ProyectoFinal_IOS
//
//  Created by user220771 on 6/2/22.
//

import Foundation
import UIKit

class viewSubirFoto: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imgPublicacion: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnAgregarImagen(_ sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        present(imgPicker,animated: true, completion: nil)
    }
    @IBAction func btnSubirImagen(_ sender: UIButton) {
        let imgBase64 = imgPublicacion.image?.crearCadena() ?? nil

        if imgBase64 != nil {
           
           /*postSubirFoto(imgBase64){
            json, error in
               if error != nil{
                    self.Alerta("Error al crear el post", error!.msg){}
               }else{
                   self.dismiss(animated: true)
               }
            }*/
        }else{
            self.Alerta("Faltan campos", "Selecciona una imagen e ingresa la descripcion"){}
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imgPublicacion.contentMode = .scaleAspectFit
            imgPublicacion.image = image
        }
        self.dismiss(animated: true, completion: nil)
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
