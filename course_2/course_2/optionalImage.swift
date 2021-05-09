//
//  optionalImage.swift
//  course_2
//
//  Created by Naryu on 2021/05/09.
//

import SwiftUI

struct optionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}
