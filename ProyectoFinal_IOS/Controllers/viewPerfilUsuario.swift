//
//  viewPerfilUsuario.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/31/22.
//

import Foundation
import UIKit

class viewPerfilUsuario:UITableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "viewCeldaPerfil", for: indexPath) as! viewCeldaPerfil
        
        return celda;
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 284
    }
    
    
    
    
}