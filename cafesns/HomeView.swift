//
//  HomeView.swift
//  cafesns
//
//  Created by Kazunari Hirosawa on 2026/06/30.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        
        ForEach(vm.posts) { post in
            Text(post.text)
        }
    }
}

#Preview {
    HomeView()
}
