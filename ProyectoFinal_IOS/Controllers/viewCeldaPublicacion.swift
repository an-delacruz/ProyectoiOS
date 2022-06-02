//
//  viewCeldaPublicacion.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/30/22.
//

import Foundation
import UIKit

class viewCeldaPublicacion:UITableViewCell{
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var Imagen: UIImageView!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    @IBAction func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        Imagen.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    
}
