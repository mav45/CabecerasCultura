import SwiftUI

struct LandingPageView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Spacer to push content towards the center
                    Spacer()

                    // Hero Section
                    ZStack {
                        // "Get Started" Button
                        NavigationLink(destination: StatesListView()) {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal, 40)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.top, 20)

                    // Image Section
                    Image("bellasArtes")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                        .shadow(radius: 12)
                        .frame(width: 250, height: 250)
                        

                    // Spacer to push content towards the center
                    Spacer()
                }
                .frame(minHeight: UIScreen.main.bounds.height) // Ensure the VStack takes full screen height
                .navigationTitle("")
                .navigationBarHidden(true) // Hide the navigation bar for a full-screen landing page
            }
        }
    }
}

// Preview section
#Preview {
    LandingPageView()
}
