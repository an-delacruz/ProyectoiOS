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
    
    
    
    override func viewDidLoad() {
        self.swSonido.isOn = defaults.bool(forKey: "sonido")
    }
    
   
    @IBAction func configuracionSonido(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "sonido")
        defaults.synchronize()
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        let decoder = JSONDecoder();
        let auth = Auth(usuario: "", token: "")
        
        let defaults = UserDefaults.standard
        
        defaults.setCustomObject(auth,forKey: "auth")
        
        print("token->\(auth)")
        
        let vista = storyboard?.instantiateViewController(identifier: "viewLoginID") as? viewLogin
        vista?.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.present(vista!, animated: true, completion: nil)
        
    }
}
