//
//  EditorView.swift
//  cafesns
//
//  Created by Kazunari Hirosawa on 2026/06/30.
//

import SwiftUI

struct EditorView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = EditorViewModel()

    var body: some View {
        NavigationStack {
            Form {
                Section("お店") {
                    TextField("例: サブウェイ 小田急ハルク店 (任意)", text: $viewModel.shopName)
                }

                Section("投稿内容") {
                    ZStack(alignment: .topLeading) {
                        if viewModel.postText.isEmpty {
                            Text("例: このカフェは静かで勉強しやすかった。ラテもおいしい。")
                                .foregroundStyle(.secondary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }

                        TextEditor(text: $viewModel.postText)
                            .frame(minHeight: 160)
                            .scrollContentBackground(.hidden)
                    }
                }

                if let errorMessage = viewModel.errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("投稿")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                    .disabled(viewModel.isSubmitting)
                }

                ToolbarItem(placement: .confirmationAction) {
                    if viewModel.isSubmitting {
                        ProgressView()
                    } else {
                        Button("投稿") {
                            Task {
                                await viewModel.submit()
                            }
                        }
                        .disabled(!viewModel.canSubmit)
                    }
                }
            }
            .interactiveDismissDisabled(viewModel.isSubmitting)
            .onChange(of: viewModel.didSubmit) { _, didSubmit in
                if didSubmit {
                    dismiss()
                }
            }
        }
    }
}


#Preview {
    EditorView()
}
