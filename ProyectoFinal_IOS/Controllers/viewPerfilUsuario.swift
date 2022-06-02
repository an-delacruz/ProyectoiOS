//
//  viewPerfilUsuario.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/31/22.
//

import Foundation
import UIKit

class viewPerfilUsuario:UITableViewController{
    
    var usuario : Usuario? ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.obtenerUsuario()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Perfil" : "Publicaciones"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : usuario?.posts.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.section)
        
        if usuario == nil {
            let celda = tableView.dequeueReusableCell(withIdentifier: "viewCeldaPerfil", for: indexPath) as! viewCeldaPerfil
            
            
            return celda;        }
        if indexPath.section == 0 {
        
            let celda = tableView.dequeueReusableCell(withIdentifier: "viewCeldaPerfil", for: indexPath) as! viewCeldaPerfil
            celda.lblNombre.text = usuario!.usuario
            celda.lblDescription.text = "\(usuario!.nombre) \(usuario!.apellido)"
            celda.imgPerfil?.cargarImagen(usuario!.foto)
            
            return celda;
        } else {
            let celda = Bundle.main.loadNibNamed("publicacionesXib", owner: self)?.first as! viewCeldaPublicacion
             //let celda = tableView.dequeueReusableCell(withIdentifier: "celdaPublicacion", for: indexPath) as! viewCeldaPublicacion
            celda.lblUsuario?.text = usuario!.posts[indexPath.row].usuario
            celda.lblDescripcion?.text = usuario!.posts[indexPath.row].descripcion
            celda.Imagen?.cargarImagen(usuario!.posts[indexPath.row].img)
             let dateFormatterGet = DateFormatter()
             dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
             let dateFormatterPrint = DateFormatter()
             dateFormatterPrint.dateFormat = "MMM dd,yyyy"
             //print(celda.lblFecha.text)
            let date = dateFormatterGet.date(from: usuario!.posts[indexPath.row].publicacion)
             //print("Fecha \(date)")
             celda.lblFecha?.text = dateFormatterPrint.string(from: date!)
             celda.contentView.layer.cornerRadius = 10
             celda.contentView.layer.masksToBounds = true
             celda.Imagen?.layer.cornerRadius = 10
             celda.Imagen?.layer.masksToBounds = true
             
             return celda
            }
      
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 30: 0
    }
    
    func obtenerUsuario(){
        let defaults = UserDefaults.standard
        let user = defaults.getCustomObject(dataType: Auth.self, key: "auth")
        getUsuario(user!.usuario){
            json,error in
            if error != nil {
                self.AlertaError(error!.msg)
            } else {
                self.usuario = json;
                self.tableView.reloadData()
            }
            
        }
    }
    
    func AlertaError(_ msg: String) {
        let dialogMessage = UIAlertController(title: "Error al cargar el perfil del usuario", message: msg, preferredStyle: .alert)
        let cerrar = UIAlertAction(title: "Cerrar", style: .default)
        dialogMessage.addAction(cerrar)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
