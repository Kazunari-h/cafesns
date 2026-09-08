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
    var id: Int
    let text: String
    let shop: String?
}

class HomeViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var posts: [Post] = [
        Post(
            id: 0,
            text: "サラダチキンがすごく美味しかった。お店も綺麗でよかったです。店員さんも丁寧でまた来ようと思います。",
            shop: "サブウェイ 小田急ハルク店"
        ),
        Post(
            id: 1,
            text: "店員さんがすごく丁寧。コーヒープレスが美味しくて過ごしやすい。お昼はすごく混むので時間を外したほうがいいです。",
            shop: nil
        )
    ]
    
    func startEventListener() {
        db.collection("posts")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    // エラーがある場合
                }
                
                if let snapshot = querySnapshot {
                    // 変更がある場合
                    
                    snapshot.documentChanges.forEach { change in
                        switch change.type {
                        case .added:
                            break
                        case .modified:
                            break
                        case .removed:
                            break
                        }
                    }
                }
            }
    }
}
