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
        
        let id = SQLiteDatabase().loginUser(usuarioValue: usuario!, senhaValue: senha!)
        
        if  id != 0 {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            vc.userID(id: id)
            self.present(vc, animated: true)
            
            
           
        } else {
            
            let alert = UIAlertController(title: "Falha no login", message: "Usuário ou senha estão incorretos!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
            
            self.present(alert, animated: true)
        }
    }
}

