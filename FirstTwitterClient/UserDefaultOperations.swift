//
//  UserDefaultOperations.swift
//  FirstTwitterClient
//
//  Created by Jing Wei Li on 12/26/17.
//  Copyright © 2017 Jing Wei Li. All rights reserved.
//

import Foundation

//check if the dictionary exists
func checkExistence(){
    if UserDefaults.standard.stringArray(forKey: "defaults") == nil{
        let defaults:[String] = []
        UserDefaults.standard.set(defaults, forKey: "defaults")
    }
}

func storeDefaults(using val:String){
    var defaults = UserDefaults.standard.stringArray(forKey: "defaults")!
    defaults.insert(val, at: 0)
    if defaults.count > 100 { defaults.removeLast() }
    UserDefaults.standard.set(defaults, forKey: "defaults")
}

func retrieveDefaults() -> [String] {
    if UserDefaults.standard.stringArray(forKey: "defaults") == nil{
        return ["Nothing"]
    }
    return UserDefaults.standard.stringArray(forKey: "defaults")!
}

func deleteDefaultsElements(at row:Int){
    var defaults = UserDefaults.standard.stringArray(forKey: "defaults")!
    defaults.remove(at: row)
    UserDefaults.standard.set(defaults, forKey: "defaults")
}
