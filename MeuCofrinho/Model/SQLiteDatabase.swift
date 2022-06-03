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
    
    
    public func loginUser(usuarioValue: String, senhaValue: String) -> Int64 {
        
        do{
           
            let usuarios = try db.prepare(users.select(id, usuario, senha))
            for user in usuarios {
                if user[usuario] == usuarioValue && user[senha] == senhaValue {
                    return user[id]
                }
            }
            
            return 0
            
        } catch {
            print(error.localizedDescription)
        }
        
    return 0
    }
    
    public func getValue(pid:Int64) -> Double {
        do{
           
            let valor = try db.prepare(users.select(id, saldo))
            for item in valor {
                if(item[id] == pid){
                    return item[saldo]
                }
            }
    
            return 0
            
        } catch {
            print(error.localizedDescription)
        }
    return 0
    }
    
    public func addValue(saldoValue: Double, pid:Int64) -> Bool {
        
        do{
            let userSaldo = users.filter(id == pid)
            try db.run(userSaldo.update(saldo <- saldo + saldoValue))
            
            return true
            
        } catch {
            print(error.localizedDescription)
        }
    return false
    }
    
    public func removeValue(saldoRemoveValue: Double, pid:Int64) -> Bool {
        
        var valor:Double = 0
        
        do{
            let usuarios = try db.prepare(users.select(id, saldo))
            for user in usuarios {
                if user[id] == pid {
                    valor = valor + user[saldo]
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        do{
           valor = valor - saldoRemoveValue
            if valor < 0{
                valor = 0
            }
            let userRemoveSaldo = users.filter(id == pid)
            try db.run(userRemoveSaldo.update(saldo <- valor))
            
            return true
            
        } catch {
            print(error.localizedDescription)
        }
    return false
    }
}
