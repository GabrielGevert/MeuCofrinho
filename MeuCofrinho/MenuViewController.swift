//
//  MenuViewController.swift
//  MeuCofrinho
//
//  Created by ALUNO on 25/05/22.
//
import SQLite
import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var inputValue: UITextField!

    @IBOutlet weak var valorAtual: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonRemoveValue(_ sender: Any) {
        var value: Double? {
            return Double(inputValue.text!)
        }
        
        if SQLiteDatabase().removeValue(saldoRemoveValue: value!) {
            print("removeu")
        }else {
            print("n removeu")
        }
    }
    
    @IBAction func buttonAddValue(_ sender: Any) {
        
        var value: Double? {
            return Double(inputValue.text!)
        }
        
        var valor: Double? {
            return Double(valorAtual.text!)
        }
        
        
        
        if SQLiteDatabase().addValue(saldoValue: value!) {
            print("adicionou")
        }else {
            print("b")
        }

    }
}
