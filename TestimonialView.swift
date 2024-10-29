import SwiftUI

struct TestimonialView: View {
    let name: String
    let feedback: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\"\(feedback)\"")
                .font(.body)
                .italic()
                .padding(.bottom, 5)
            
            Text("- \(name)")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
