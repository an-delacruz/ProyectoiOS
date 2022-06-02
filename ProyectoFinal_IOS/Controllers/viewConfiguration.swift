//
//  viewConfiguration.swift
//  ProyectoFinal_IOS
//
//  Created by Karla Marquez on 5/30/22.
//

import Foundation
import UIKit

class viewConfiguration:UIViewController{
    
    
    @IBOutlet weak var swSonido: UISwitch!
    
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var swDarkMode: UISwitch!
    
    override func viewDidLoad() {
        self.swSonido.isOn = defaults.bool(forKey: "sonido")
    }
    
   
    @IBAction func configuracionSonido(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "sonido")
        defaults.synchronize()
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
       
        defaults.removeObject(forKey: "auth")
        self.view?.window?.rootViewController?.dismiss(animated: true, completion: nil)
    
    }
    
    
}
