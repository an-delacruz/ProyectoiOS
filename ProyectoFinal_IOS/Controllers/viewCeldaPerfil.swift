//
//  viewCeldaPerfil.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/31/22.
//

import Foundation
import UIKit

class viewCeldaPerfil:UITableViewCell{
    
    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnConfiguracion: UIButton!
    @IBOutlet weak var btnImagenes: UIBarButtonItem!
    
    var zoomEnabled = false
    var imgCenter: CGPoint?
    override func awakeFromNib() {
        super.awakeFromNib()
       
        imgPerfil.contentMode = .scaleAspectFill
        imgPerfil.isUserInteractionEnabled = true
        imgPerfil.clipsToBounds = false
        
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture(_:)))
        pinch.delegate = self
        self.imgPerfil.addGestureRecognizer(pinch)
    }
    @IBAction func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
            let currentScale = self.imgPerfil.frame.size.width / self.imgPerfil.bounds.size.width
            let newScale = currentScale * sender.scale
            if newScale > 1 {
                self.zoomEnabled = true
            }
        } else if sender.state == .changed {
            guard let view = sender.view else {return}
            let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX, y: sender.location(in: view).y - view.bounds.midY)
            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: sender.scale, y: sender.scale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            let currentScale = self.imgPerfil.frame.size.width / self.imgPerfil.bounds.size.width
            var newScale = currentScale * sender.scale
            if newScale < 1 {
                newScale = 1
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                self.imgPerfil.transform = transform
                sender.scale = 1
            }else {
                view.transform = transform
                sender.scale = 1
            }
        } else if sender.state == .ended {
            guard let center = self.imgCenter else {return}
            UIView.animate(withDuration: 0.3, animations: {
                self.imgPerfil.transform = CGAffineTransform.identity
                self.imgPerfil.center = center
            }, completion: { _ in
                self.zoomEnabled = false
            })
        }
    }
}

