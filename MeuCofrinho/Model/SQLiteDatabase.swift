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
            let path: String = NSSearchPatchForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            db = try Connection("\(patch)/my_users.sqlite3")
            
            users = Table("users")
            
            id = Expression<Int64>("id")
            usuario = Expression<String>("usuario")
            senha = Expression<String>("senha")
            saldo = Expression<Double>("saldo")
            
            try db?.run(table.create(ifNotExists: true){
                t in
                t.column(id, primaryKey: .autoincrement)
                t.column(usuario, unique: true)
                t.column(senha)
                t.column(saldo, defaultValue: 0.00)
            })
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    public func addUser(usuarioValue: String, senhaValue: String, saldoValue: Double) {
        do {
            try db.run(users.insert(usuario <- usuarioValue, senha <- senhaValue))
        } catch {
            print(error.localizedDescription)
        }
    }
}
