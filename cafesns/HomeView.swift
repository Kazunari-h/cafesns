//
//  HomeView.swift
//  cafesns
//
//  Created by Kazunari Hirosawa on 2026/06/30.
//

import SwiftUI

struct HomeView: View {

    @StateObject var vm = HomeViewModel()
    @State private var isShowingEditor = false

    var body: some View {
        NavigationStack {
            Group {
                if let errorMessage = vm.errorMessage {
                    ContentUnavailableView(
                        "読み込みエラー",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                } else if vm.isLoading && vm.posts.isEmpty {
                    ProgressView("読み込み中…")
                } else if vm.posts.isEmpty {
                    ContentUnavailableView(
                        "投稿がありません",
                        systemImage: "cup.and.saucer",
                        description: Text("最初のカフェの口コミを投稿してみましょう。")
                    )
                } else {
                    List(vm.posts) { post in
                        PostRow(post: post)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("ホーム")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingEditor = true
                    } label: {
                        Label("投稿する", systemImage: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $isShowingEditor) {
                EditorView()
            }
        }
        .onAppear {
            vm.startEventListener()
        }
    }
}

/// 投稿1件分の行
struct PostRow: View {

    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let shop = post.shop, !shop.isEmpty {
                Label(shop, systemImage: "mappin.and.ellipse")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Text(post.text)
                .font(.body)

            if let createdAt = post.createdAt {
                Text(createdAt, format: .dateTime.year().month().day().hour().minute())
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HomeView()
}
