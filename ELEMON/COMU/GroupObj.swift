//
//  GroupObj.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/31.
//

import Foundation
import RealmSwift

class GroupObj: Object, Identifiable{
    @Persisted var hostId: String
    @Persisted var name: String
    @Persisted var context: String
    @Persisted var checked: Bool = false
}

