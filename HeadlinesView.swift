import SwiftUI

struct HeadlinesView: View {
    let state: String
    @State private var headlines: [Headline] = []
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    if headlines.isEmpty {
                        ProgressView()
                            .onAppear {
                                WebScraper.fetchHeadlines(for: state) { fetchedHeadlines in
                                    self.headlines = fetchedHeadlines
                                }
                            }
                            .frame(height: 100) // Maintain consistent spacing
                            .padding(.top, geometry.safeAreaInsets.top + 20) // Adjust top padding
                    } else {
                        ForEach(headlines) { headline in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(headline.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 5) // Consistent spacing below title
                                
                                Link(destination: URL(string: headline.url)!) {
                                    Text("Read more")
                                        .font(.subheadline)
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .shadow(color: Color(.black).opacity(0.1), radius: 4, x: 0, y: 2)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 16) // Consistent horizontal padding
                        }
                    }
                }
                .padding(.top, 16) // Consistent top padding for content
            }
            .navigationTitle(state)
            .navigationBarTitleDisplayMode(.inline) // Inline title for consistency
        }
    }
}

