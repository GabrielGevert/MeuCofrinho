//
//  RegistroViewController.swift
//  MeuCofrinho
//
//  Created by ALUNO on 25/05/22.
//

import UIKit

class RegistroViewController: UIViewController {

    @IBOutlet weak var usuarioRegistro: UITextField!
    
    @IBOutlet weak var senhaRegistro: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickRegister(_ sender: UIButton) {
        
        let usuario: String? =
        self.usuarioRegistro.text
        
        let senha: String? =
        self.senhaRegistro.text
        
        if SQLiteDatabase().addUser(usuarioValue: usuario!, senhaValue: senha!) {
            
            let alert = UIAlertController(title: "Registro feito com sucesso", message: "Voce ja pode fazer login no sistema", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in self.dismiss(animated: true, completion: nil)}))
            
            self.present(alert, animated: true)
            
        } else {
            
            let alert = UIAlertController(title: "Falha no Registro", message: "Este usuário já está em nosso sistema!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
            
            self.present(alert, animated: true)
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
