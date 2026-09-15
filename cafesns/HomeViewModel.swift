//
//  HomeViewModel.swift
//  cafesns
//
//  Created by Kazunari Hirosawa on 2026/07/07.
//

import Combine
import FirebaseCore
import FirebaseFirestore

// 投稿 (Post)
struct Post: Identifiable {
    /// FirestoreのドキュメントID
    let id: String
    let text: String
    let shop: String?
    let createdAt: Date?

    /// Firestoreのドキュメントから投稿を生成する。
    /// 必須フィールド (text) が無いドキュメントは nil を返す。
    init?(document: DocumentSnapshot) {
        guard let data = document.data(),
              let text = data["text"] as? String else {
            return nil
        }
        self.id = document.documentID
        self.text = text
        self.shop = data["shop"] as? String
        self.createdAt = (data["createdAt"] as? Timestamp)?.dateValue()
    }
}

@MainActor
class HomeViewModel: ObservableObject {

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    @Published var posts: [Post] = []
    @Published var errorMessage: String?
    @Published var isLoading = false

    deinit {
        listener?.remove()
    }

    /// posts コレクションの変更を監視して posts を更新する。
    func startEventListener() {
        // 二重登録を防ぐ
        guard listener == nil else { return }

        isLoading = true
        errorMessage = nil

        listener = db.collection("posts")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self else { return }
                self.isLoading = false

                if let error {
                    self.errorMessage = "投稿の取得に失敗しました: \(error.localizedDescription)"
                    return
                }

                guard let snapshot = querySnapshot else { return }

                // スナップショット全体で置き換える (追加・更新・削除をまとめて反映)
                self.posts = snapshot.documents.compactMap { Post(document: $0) }
            }
    }

    func stopEventListener() {
        listener?.remove()
        listener = nil
    }
}
