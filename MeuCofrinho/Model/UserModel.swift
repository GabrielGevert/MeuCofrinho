//
//  UserModel.swift
//  MeuCofrinho
//
//  Created by Gabriel Gevert on 25/05/22.
//

import Foundation

class UserModel: Identifiable {
    public var id: Int64 = 0
    public var usuario: String = ""
    public var senha: String = ""
    public var saldo: Double = 0.00
}
