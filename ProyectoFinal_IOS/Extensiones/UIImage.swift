//
//  UIImage.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/31/22.
//

import Foundation
import UIKit
extension UIImage
{
    func crearCadena() -> String
    {
        let imagenData = self.jpegData(compressionQuality: CGFloat(0))
        let imagenCadena = imagenData?.base64EncodedString()
        
        return imagenCadena!
    }
}
