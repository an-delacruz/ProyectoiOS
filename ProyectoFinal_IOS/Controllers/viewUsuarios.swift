//
//  viewSeguido.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 6/1/22.
//

import Foundation
import UIKit

class viewUsuarios:UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaUsuario", for: indexPath) as! viewCeldaUsuario

        celda.lblNombre?.text = "\(usuarios[indexPath.row].nombre)  \(usuarios[indexPath.row].apellido)"
        celda.lblUsuario?.text = usuarios[indexPath.row].usuario
        celda.imgUsuario.cargarImagen(usuarios[indexPath.row].foto)
        //print(usuarios[indexPath.row].seguido)
        if usuarios[indexPath.row].seguido{
            celda.btnSeguir.isEnabled = false
        }
        celda.imgUsuario.layer.borderWidth = 1
        celda.imgUsuario.layer.masksToBounds = false
        celda.imgUsuario.layer.borderColor = UIColor.black.cgColor
        celda.imgUsuario.layer.cornerRadius = celda.imgUsuario.frame.height/2
        celda.imgUsuario.clipsToBounds = true
        return celda
    }
    func updateData(){
        getUsuarios(){
            json, error in
            usuarios = json as! [UsuarioStruct]
            print(usuarios)
            let defaults = UserDefaults.standard
            let def = defaults.getCustomObject(dataType: Auth.self, key: "auth")
            let usuario = def?.usuario;
            usuarios = usuarios.filter {user in
                return user.usuario != usuario}

            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}
