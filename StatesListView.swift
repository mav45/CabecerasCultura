import SwiftUI

struct StatesListView: View {
    let states = ["Tampico", "Querétaro", "Mexico City", "Mexico City 2", "Michoacán", "Córdoba", "Orizaba", "Irapuato", "Salamanca", "San Juan del Río", "El Bajío", "León", "Xalapa", "Chiapas", "Tabasco", "Guadalajara", "San Luis Potosí", "Morelia", "Toluca", "Zamora", "Aguascalientes", "Cuernavaca", "Puebla", "Tlaxcala", "Hidalgo", "Hermosillo", "Chihuahua", "Juárez", "Durango", "Parral", "Zacatecas", "Coahuila", "Sonora", "Acapulco", "Mazatlán", "Tijuana", "La Paz", "Mexicali"]

    var body: some View {
        NavigationView {
            List(states, id: \.self) { state in
                NavigationLink(destination: HeadlinesView(state: state)) {
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.accentColor)
                        Text(state)
                            .font(.body)
                            .foregroundColor(.primary)
                            .accessibilityLabel("\(state) selected")
                    }
                    .padding(.vertical, 8) // Consistent padding for each row
                }
            }
            .navigationTitle("Noticias Culturales - Select Local")
            .navigationBarTitleDisplayMode(.inline) // Inline title to save space
        }
    }
}
