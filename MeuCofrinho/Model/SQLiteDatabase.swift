//
//  SQLiteDatabase.swift
//  MeuCofrinho
//
//  Created by Gabriel Gevert on 25/05/22.
//

import Foundation
import SQLite

class SQLiteDatabase{
    private var db: Connection!
    
    private var users: Table!
    
    private var id: Expression<Int64>!
    private var usuario: Expression<String>!
    private var senha: Expression<String>!
    private var saldo: Expression<Double>!
    
    init(){
        do{
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            db = try Connection("\(path)/my_users.sqlite3")
            
            users = Table("users")
            
            id = Expression<Int64>("id")
            usuario = Expression<String>("usuario")
            senha = Expression<String>("senha")
            saldo = Expression<Double>("saldo")
            
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                try db.run(users.create { (t) in
                    t.column(id, primaryKey: .autoincrement)
                    t.column(usuario, unique: true)
                    t.column(senha)
                    t.column(saldo, defaultValue: 0.00)
                })
                
                UserDefaults.standard.set(true, forKey: "is_db_created")
        }
        
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func addUser(usuarioValue: String, senhaValue: String) -> Bool {
        do{
        try db.run(users.insert(usuario <- usuarioValue, senha <- senhaValue))

            return true
        } catch {
            print(error.localizedDescription)
        }
    return false
    }
    
    public func loginUser(usuarioValue: String, senhaValue: String) -> Bool {
        do{
            let usuarios = try db.prepare("SELECT usuario,senha FROM users WHERE usuario = '" + usuarioValue + "' AND senha = '" + senhaValue + "'")
            for nome in usuarios {
                print(nome)
                return true
            }
            return false
            
        } catch {
            print(error.localizedDescription)
        }
    return false
    }
    
//    public func getSaldo(saldoNovo: Double) -> Double {
//        do{
//            let saldao = try db.prepare("SELECT saldo FROM users WHERE usuario = 'piriquito'")
//            for saldoNovo in saldao {
//                return saldoNovo
//                print(saldoNovo)
//            }
//
//
//        }
//    }
//
    
    
    
    
    
    public func addValue(saldoValue: Double) -> Bool {
        
        do{
            let userSaldo = users.filter(usuario == "piriquito")
            try db.run(userSaldo.update(saldo <- saldo + saldoValue))
            
            let saldao = try db.prepare("SELECT * FROM users WHERE usuario = 'piriquito'")
            for td in saldao {
                print(td)
            }
            return true
            
            
        } catch {
            print(error.localizedDescription)
        }
    return false
    }
    
    public func removeValue(saldoRemoveValue: Double) -> Bool {
        do{
            let userRemoveSaldo = users.filter(usuario == "piriquito")
            try db.run(userRemoveSaldo.update(saldo <- saldo - saldoRemoveValue))
            
            let removeSaldao = try db.prepare("SELECT * FROM users WHERE usuario = 'piriquito'")
            for tds in removeSaldao {
                print(tds)
                
            }
            return true
            
            
        } catch {
            print(error.localizedDescription)
        }
    return false
    }
}
