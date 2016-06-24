//
//  ImageCollectionViewCell.swift
//  INSTGRM
//
//  Created by Michael Sweeney on 6/22/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var post: Post? {
        didSet {
            self.imageView.image = self.post?.image
            
        }
    }
    
    class func id() -> String {
        return String(self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
}
