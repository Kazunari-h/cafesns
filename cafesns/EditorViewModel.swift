//
//  EditorViewModel.swift
//  cafesns
//
//  Created by Kazunari Hirosawa on 2026/06/30.
//

import Foundation
import Combine
import FirebaseFirestore

@MainActor
final class EditorViewModel: ObservableObject {

    private let db = Firestore.firestore()

    @Published var postText: String = ""
    @Published var shopName: String = ""
    @Published var isSubmitting = false
    @Published var errorMessage: String?
    /// 投稿が完了したら true になる (画面を閉じる合図)
    @Published var didSubmit = false

    var canSubmit: Bool {
        !postText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isSubmitting
    }

    /// posts コレクションに投稿を追加する。
    func submit() async {
        guard canSubmit else { return }

        isSubmitting = true
        errorMessage = nil

        let text = postText.trimmingCharacters(in: .whitespacesAndNewlines)
        let shop = shopName.trimmingCharacters(in: .whitespacesAndNewlines)

        var data: [String: Any] = [
            "text": text,
            "createdAt": FieldValue.serverTimestamp(),
        ]
        if !shop.isEmpty {
            data["shop"] = shop
        }

        do {
            try await db.collection("posts").addDocument(data: data)
            clearDraft()
            didSubmit = true
        } catch {
            errorMessage = "投稿に失敗しました: \(error.localizedDescription)"
        }

        isSubmitting = false
    }

    func clearDraft() {
        postText = ""
        shopName = ""
    }
}
