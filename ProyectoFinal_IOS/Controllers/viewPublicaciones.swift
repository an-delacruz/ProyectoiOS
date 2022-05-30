//
//  viewPublicaciones.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/28/22.
//

import Foundation
import UIKit

class viewPublicaciones:UITableViewController{
    @IBOutlet weak var toolAgregar: UIBarButtonItem!
    
    @IBOutlet weak var toolConfiguraciones: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPublicaciones()

    }
    func reloadData(){
        print("Se recargan los datos")
        print("Posts Recargados -> \(posts)")

        self.tableView.reloadData()
        self.tableView.refreshControl?
            .endRefreshing()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Posts Recargados -> \(posts)")
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaPublicacion", for: indexPath) as! viewCeldaPublicacion
        celda.lblUsuario?.text = posts[indexPath.row].usuario
        celda.lblDescripcion?.text = posts[indexPath.row].descripcion
        
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: posts[indexPath.row].publicacion)
        celda.lblFecha?.text = dateFormatterPrint.string(from: date!)
        
        return celda
    }
}
