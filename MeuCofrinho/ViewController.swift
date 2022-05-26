//
//  ViewController.swift
//  MeuCofrinho
//
//  Created by ALUNO on 05/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usuarioText: UITextField!
    
    @IBOutlet weak var senhaText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func entrarBotao(_ sender: Any) {
        let usuario: String? =
        self.usuarioText.text
        
        let senha: String? =
        self.senhaText.text
        
        if SQLiteDatabase().loginUser(usuarioValue: usuario!, senhaValue: senha!) {
            
            let storyboard = UIStoryboard(name: "menu", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
            self.present(vc, animated: true)
            
           
        } else {
            print("else")
        }
        
    }
    
}

