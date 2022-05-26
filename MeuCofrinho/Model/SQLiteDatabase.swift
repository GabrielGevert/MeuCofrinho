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
            print("Deu certo")
            return true
        } catch {
            print(error.localizedDescription)
        }
    return false
    }
    
    public func loginUser(usuarioValue: String, senhaValue: String) -> Bool {
        do{
//
            
            
            
            
//            try db.run(users.select(usuario: Expression<usuarioValue>))
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
    
}
