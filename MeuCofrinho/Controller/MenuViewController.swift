//
//  MenuViewController.swift
//  MeuCofrinho
//
//  Created by ALUNO on 25/05/22.
//
import SQLite
import UIKit

class MenuViewController: UIViewController {
    var id: Int64 = 0
    @IBOutlet weak var inputValue: UITextField!
    
    @IBOutlet weak var labelValue: UILabel!
    
    @IBOutlet weak var inputAdvice: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var value = SQLiteDatabase().getValue(pid: self.id)
        if value < 0 {
            value = 0
        }
        
        labelValue.text =  String(format: "%.2f", value)

    }
    
    @IBAction func logout(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        
        self.present(vc, animated: true)
        
    }
    
    func userID(id: Int64){
        self.id = id
    }
    
    @IBAction func buttonRemoveValue(_ sender: Any) {
        
        var value: Double? {
            
            return Double(inputValue.text!.replacingOccurrences(of: ",", with: "."))
        }
        
        if value == nil{
            
            let alert = UIAlertController(title: "Valor invalido!", message: "Digite um valor valido.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
            
            self.present(alert, animated: true)
            return
        }
        
        
        if SQLiteDatabase().removeValue(saldoRemoveValue: value!, pid: self.id) {
            self.viewDidLoad()
        }
    }
    @IBAction func historico(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerHistorico") as! ViewControllerHistorico
        
        vc.carregar(id: self.id)
        
        self.present(vc, animated: true)
    }

    @IBAction func addValue(_ sender: UIButton) {
        var value: Double? {
            return Double(inputValue.text!.replacingOccurrences(of: ",", with: "."))
        }
        
        var adviceValue: String? {
            return String(inputAdvice.text!)
        }
        
        if value == nil{
            
            let alert = UIAlertController(title: "Valor invalido!", message: "Digite um valor valido.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
            
            self.present(alert, animated: true)
            return
        }
        
         if SQLiteDatabase().addValue(saldoValue: value!, pid: self.id) {
            self.viewDidLoad()
            
             if SQLiteDatabase().addObs(adviceValue: adviceValue!, pid: self.id, pvalor: value!){
                print("oi")
            }
            
        
    }

    }
}
