//
//  ContentView.swift
//  Learn
//
//  Created by Mohammad Azam on 7/14/22.
//

import SwiftUI

class AppState: ObservableObject {
    
    @Published var tweets: [Tweet] = [Tweet(text: "Tweet 1", like: false), Tweet(text: "Tweet 2", like: false)]
    
    func getById(_ id: UUID) -> Tweet? {
        
        guard let index = tweets.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        
        return tweets[index]
    }
     
}

struct Tweet: Identifiable, Hashable {
    let text: String
    var like: Bool
    let id = UUID()
}

struct DetailView: View {
    
    @EnvironmentObject var appState: AppState
    let tweet: Tweet
    
    var body: some View {
        let _ = print(Self._printChanges())
        if let tweet = appState.getById(tweet.id) {
            TweetCellView(tweet: tweet)
        }
       
    }
}


struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        let _ = print(Self._printChanges())
        List(appState.tweets) { tweet in
            NavigationLink(value: Route.detail(tweet)) {
                TweetCellView(tweet: tweet)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppState())
    }
}

struct TweetCellView: View {

    @EnvironmentObject var appState: AppState
    let tweet: Tweet
    
    var body: some View {
        let _ = print(Self._printChanges())
        HStack {
            Text(tweet.text)
            Spacer()
            Image(systemName: tweet.like ? "heart.fill": "heart")
                .onTapGesture {
                    // find the tweet
                    guard let index = appState.tweets.firstIndex(where: { $0.id == tweet.id }) else { return }
                    appState.tweets[index].like.toggle()
                }
        }
    }
}
