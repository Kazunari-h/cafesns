//
//  EditorViewModel.swift
//  cafesns
//
//  Created by Kazunari Hirosawa on 2026/06/30.
//

import Foundation
import Combine

final class EditorViewModel: ObservableObject {
    @Published var postText: String = ""

    var canSubmit: Bool {
        !postText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func clearDraft() {
        postText = ""
    }
}
