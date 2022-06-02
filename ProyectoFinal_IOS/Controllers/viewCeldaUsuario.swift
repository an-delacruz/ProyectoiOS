//
//  viewCeldaUsuario.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 6/1/22.
//

import UIKit

class viewCeldaUsuario: UITableViewCell {

    @IBOutlet weak var btnSeguir: UIButton!
    @IBOutlet weak var imgUsuario: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblUsuario: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnSeguir(_ sender: UIButton) {
        guard let usuarioString = lblUsuario.text else { return }
        let usuario = SeguirUsuario(usuario: usuarioString)
        postSeguirUsuario(usuario){
            json, error in
            if error == nil {
                self.btnSeguir.isEnabled = false
                print(json)
             } else {
                 print(error!.msg)

             }
        }
        btnSeguir.isEnabled = false;
    }

}
