//
//  Post.swift
//  INSTGRM
//
//  Created by Michael Sweeney on 6/21/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

class Post {
    
    var image: UIImage
    
    init(image: UIImage){
        self.image = image
    }
    
    convenience init() {
        self.init(image: UIImage())
    }
}
