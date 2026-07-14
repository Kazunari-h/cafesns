//
//  EditorView.swift
//  cafesns
//
//  Created by Kazunari Hirosawa on 2026/06/30.
//

import SwiftUI

struct EditorView2: View {
    
    @StateObject var vm: EditorViewModel2

    var body: some View {
        NavigationStack {
            Form {
                Section("投稿内容") {
                    ZStack(alignment: .topLeading) {
                        if vm.postText.isEmpty {
                            Text("例: このカフェは静かで勉強しやすかった。ラテもおいしい。")
                                .foregroundStyle(.secondary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }

                        TextEditor(text: $vm.postText)
                            .frame(minHeight: 160)
                            .scrollContentBackground(.hidden)
                    }
                }



                
            }
            .navigationTitle("投稿")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("投稿") {
                    }
                    .disabled(!vm.canSubmit)
                }
            }
        }
    }
}


#Preview {
    EditorView()
}
 
