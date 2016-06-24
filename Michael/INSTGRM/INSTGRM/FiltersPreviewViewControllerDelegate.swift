//
//  FiltersPreviewViewControllerDelegate.swift
//  INSTGRM
//
//  Created by Michael Sweeney on 6/23/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

protocol FiltersPreviewViewControllerDelegate: class {
    func didFinishPickingImage(success: Bool, image: UIImage?) -> ()
}
