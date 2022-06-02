//
//  viewPublicaciones.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/28/22.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox


class viewPublicaciones:UITableViewController{
    @IBOutlet weak var toolAgregar: UIBarButtonItem!
    
    @IBOutlet weak var toolConfiguraciones: UIBarButtonItem!
    
    @IBAction func btnAgregarPost(_ sender: UIBarButtonItem) {
        print("Agregar post")
        let vista = storyboard?.instantiateViewController(identifier: "viewCrearPublicacion") as? viewCrearPublicacion
        vista?.modalPresentationStyle = .fullScreen

        self.navigationController?.present(vista!, animated: true, completion: nil)
    }
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if(defaults.bool(forKey: "sonido")){
            AudioServicesPlaySystemSound(SystemSoundID(1000))
        }
        getPublicaciones(){
            json, error in
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Posts Recargados -> \(posts)")
        let celda = Bundle.main.loadNibNamed("publicacionesXib", owner: self)?.first as! viewCeldaPublicacion
        //let celda = tableView.dequeueReusableCell(withIdentifier: "celdaPublicacion", for: indexPath) as! viewCeldaPublicacion
        celda.lblUsuario?.text = posts[indexPath.row].usuario
        celda.lblDescripcion?.text = posts[indexPath.row].descripcion
        celda.Imagen?.cargarImagen(posts[indexPath.row].img)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        //print(celda.lblFecha.text)
        let date = dateFormatterGet.date(from: posts[indexPath.row].publicacion)
        //print("Fecha \(date)")
        celda.lblFecha?.text = dateFormatterPrint.string(from: date!)
        celda.contentView.layer.cornerRadius = 10
        celda.contentView.layer.masksToBounds = true
        celda.Imagen?.layer.cornerRadius = 10
        celda.Imagen?.layer.masksToBounds = true
        
        return celda
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 301
    }
    @IBAction func refreshData(_ sender: Any) {
        getPublicaciones(){
            json, error in
            self.tableView.reloadData();
            self.refreshControl?.endRefreshing()
        }
    }
    
    
    
    @IBAction func btnMostrarPerfil(_ sender: Any) {
        let vista = storyboard?.instantiateViewController(identifier: "viewPerfilUsuario") as? viewPerfilUsuario
        vista?.modalPresentationStyle = .fullScreen

        
        
        
        self.navigationController?.present(vista!, animated: true, completion: nil)        
    }
    
    
    
    
}
