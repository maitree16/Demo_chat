//
//  File.swift
//  demo_message
//
//  Created by Johann Werner on 09.02.21.
//  Copyright © 2021 virtual height. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
