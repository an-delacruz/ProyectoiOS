//
//  viewCrearPublicacion.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/31/22.
//

import UIKit

class viewCrearPublicacion: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imgPublicacion: UIImageView!
    @IBOutlet weak var txtDescripcion: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnAgregarImagen(_ sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        present(imgPicker,animated: true, completion: nil)
    }
    @IBAction func btnAgregarPost(_ sender: UIButton) {
        let imgBase64 = imgPublicacion.image?.crearCadena() ?? nil
        let descripcion = txtDescripcion.text ?? ""
        print()
        if(validarInformacion(imgBase64, descripcion)){
           let publicacion = PublicacionPost(descripcion: descripcion, img: imgBase64!)
           postPublicacion(publicacion){
            json, error in
               if error != nil{
                    self.Alerta("Error al crear el post", error!.msg){}
               }else{
                   self.dismiss(animated: true)
               }
            }
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
    func validarInformacion(_ imgBase64:Any?, _ descripcion:String) -> Bool
    {
        if imgBase64 != nil && descripcion != ""{
            return true
        }
        return false
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
