//
//  viewCeldaPublicacion.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/30/22.
//

import Foundation
import UIKit

class viewCeldaPublicacion:UITableViewCell, UIScrollViewDelegate{
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var Imagen: UIImageView!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    var zoomEnabled = false
    var imgCenter:CGPoint?
    override func awakeFromNib() {
        super.awakeFromNib()
        Imagen.contentMode = .scaleAspectFit
        Imagen.isUserInteractionEnabled = true
        Imagen.clipsToBounds = false

        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture(_:)))
        pinch.delegate = self
        self.Imagen.addGestureRecognizer(pinch)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
         pan.delegate = self
         self.Imagen.addGestureRecognizer(pan)
    }

    
    @IBAction func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
            let currentScale = self.Imagen.frame.size.width / self.Imagen.bounds.size.width
            let newScale = currentScale * sender.scale
            if newScale > 1 {
                self.zoomEnabled = true
            }
        } else if sender.state == .changed {
            guard let view = sender.view else {return}
            let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,y: sender.location(in: view).y - view.bounds.midY)
            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: sender.scale, y: sender.scale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            let currentScale = self.Imagen.frame.size.width / self.Imagen.bounds.size.width
            var newScale = currentScale * sender.scale
            if newScale < 1 {
                newScale = 1
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                self.Imagen.transform = transform
                sender.scale = 1
            }else {
                view.transform = transform
                sender.scale = 1
            }
        } else if sender.state == .ended {
            guard let center = self.imgCenter else {return}
            UIView.animate(withDuration: 0.3, animations: {
                self.Imagen.transform = CGAffineTransform.identity
                self.Imagen.center = center
            }, completion: { _ in
                self.zoomEnabled = false
            })
        }
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        if self.zoomEnabled && sender.state == .began {
            self.imgCenter = sender.view?.center
        } else if self.zoomEnabled && sender.state == .changed {
            let translation = sender.translation(in: self)
            if let view = sender.view {
                view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
            }
            sender.setTranslation(CGPoint.zero, in: self.Imagen.superview)
        }
    }
}
