//
//  UIImageView.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/30/22.
//

import Foundation
import UIKit
extension UIImageView
{
    func cargarImagen(_ url: String)
    {
        guard let urlImagen = URL(string: url)
        else
        {
            return
        }
        
        DispatchQueue.main.async(execute:
        {
            do
            {
                let imageData = try Data(contentsOf: urlImagen)
                
                let imagen = UIImage(data: imageData)
                self.image = imagen
            }
            catch
            {
                print(error.localizedDescription)
            }
        })
    }
}
