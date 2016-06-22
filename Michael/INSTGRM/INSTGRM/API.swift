//
//  API.swift
//  INSTGRM
//
//  Created by Michael Sweeney on 6/21/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import CloudKit
import Foundation

class API {
    typealias APICompletion = (success: Bool) -> ()
    static let shared = API()
    
    let container: CKContainer
    let database: CKDatabase
    
    private init(){
        self.container = CKContainer.defaultContainer()
        self.database = self.container.privateCloudDatabase
    }
    
    func write(post: Post, completion: APICompletion){
        
        do{
            if let record = try Post.recordWith(post) {
                self.database.saveRecord(record, completionHandler: { (record, error) in
                    if error == nil && record != nil {
                        print(record)
                        completion(success: true)
                    }
                    else {
                        print(error)
                    }
                })
            }
            
        } catch let error {print(error)}
    }
}
