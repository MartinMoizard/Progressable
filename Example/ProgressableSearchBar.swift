//
//  ProgressableSearchBar.swift
//  Progressable
//
//  Created by Martin MOIZARD-LANVIN on 21/09/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import Foundation
import UIKit

class ProgressSearchBar: UISearchBar, Progressable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initProgress()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initProgress()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutProgress()
    }
}
