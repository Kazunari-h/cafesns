//
//  EditorViewModel.swift
//  cafesns
//
//  Created by Kazunari Hirosawa on 2026/06/30.
//

import Foundation
import Combine

class EditorViewModel2: ObservableObject {
    
    @Published var postText: String = ""

    var canSubmit: Bool {
        !postText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // submit
}
