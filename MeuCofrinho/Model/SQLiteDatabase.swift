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
    private var advices: Table!
    
    private var id: Expression<Int64>!
    private var usuario: Expression<String>!
    private var senha: Expression<String>!
    private var saldo: Expression<Double>!
    
    private var id_obs: Expression<Int64>!
    private var user_id: Expression<Int64>!
    private var valor: Expression<Double>!
    private var observacao: Expression<String>!
    
    init(){
        
        do{
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            db = try Connection("\(path)/my_users.sqlite3")
            
            users = Table("users")
            
            id = Expression<Int64>("id")
            usuario = Expression<String>("usuario")
            senha = Expression<String>("senha")
            saldo = Expression<Double>("saldo")
            
            advices = Table("advices")
            
            id_obs = Expression<Int64>("id_obs")
            user_id = Expression<Int64>("user_id")
            valor = Expression<Double>("valor")
            observacao = Expression<String>("observacao")
           
            
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                UserDefaults.standard.set(true, forKey: "is_db_created")

               
                
                try db.run(users.create { (t) in
                    t.column(id, primaryKey: .autoincrement)
                    t.column(usuario, unique: true)
                    t.column(senha)
                    t.column(saldo, defaultValue: 0.00)
                })
                try db.run(advices.create { (j) in
                    j.column(id_obs, primaryKey: .autoincrement)
                    j.column(user_id)
                    j.column(valor)
                    j.column(observacao)
                })
                
        }
        
        } catch {
            UserDefaults.standard.set(false, forKey: "is_db_created")

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
    
    public func addObs(adviceValue: String, pid:Int64, pvalor: Double) -> Bool {
        do{
            try db.run(advices.insert(observacao <- adviceValue, user_id <- pid, valor <- pvalor))
        
            
            return true
        } catch {
            print(error.localizedDescription)
            print("erro")
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
    
    public func getValues(pid:Int64) -> [Double] {
        do{
            var ret: [Double] = []
            let valor = try db.prepare(users.select(id, saldo))
            for item in valor {
                if(item[id] == pid){
                    ret.append(item[saldo])
                    
                }
            }
    
            return ret
            
        } catch {
            print(error.localizedDescription)
        }
    return []
    }
    
    class RetornoHistorico{
        var obs: String
        var value: Double
        init(pobs:String, pvalue:Double){
            self.obs = pobs
            self.value = pvalue
        }
        
    }
    
    public func getobs(pid:Int64) -> [RetornoHistorico] {
        do{
            var arrHistorico: [RetornoHistorico] = []
            let obs = try db.prepare(advices.select(user_id, observacao, valor))
            for item in obs {
                if(item[user_id] == pid){
                    
                
                    let novoitem = RetornoHistorico(pobs: item[observacao], pvalue: item[valor])
                    arrHistorico.append(novoitem)
                }
            }
    
            return arrHistorico
            
        } catch {
            print(error.localizedDescription)
        }
    return []
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
