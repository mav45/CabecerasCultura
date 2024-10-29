import Foundation
import SwiftSoup

class WebScraper {
    static func fetchHeadlines(for state: String, completion: @escaping ([Headline]) -> Void) {
        // Define URLs for each state
        
        let urls: [String: String] = [
            "Tampico": "https://www.elsoldetampico.com.mx/cultura/",
            "Querétaro": "https://www.diariodequeretaro.com.mx/cultura/",
            "Mexico City": "https://www.elsoldemexico.com.mx/cultura/",
            "Mexico City 2": "https://www.la-prensa.com.mx/cultura/",
            "Michoacán": "https://www.elsoldezamora.com.mx/cultura/",
            "Córdoba": "https://www.elsoldecordoba.com.mx/cultura/",
            "Orizaba": "https://www.elsoldeorizaba.com.mx/cultura/",
            "Irapuato": "https://www.elsoldeirapuato.com.mx/cultura/",
            "Salamanca": "https://www.elsoldesalamanca.com.mx/cultura/",
            "San Juan del Río": "https://www.elsoldesanjuandelrio.com.mx/cultura/",
            "El Bajío": "https://www.elsoldelbajio.com.mx/cultura/",
            "León": "https://www.elsoldeleon.com.mx/cultura/",
            "Xalapa": "https://www.diariodexalapa.com.mx/cultura/",
            "Chiapas": "https://www.elheraldodechiapas.com.mx/cultura/",
            "Tabasco": "https://www.elheraldodetabasco.com.mx/cultura/",
            "Guadalajara": "https://www.eloccidental.com.mx/cultura/",
            "San Luis Potosí": "https://www.elsoldesanluis.com.mx/cultura/",
            "Morelia": "https://www.elsoldemorelia.com.mx/cultura/",
            "Toluca": "https://www.elsoldetoluca.com.mx/cultura/",
            "Zamora": "https://www.elsoldezamora.com.mx/cultura/",
            "Aguascalientes": "https://www.elsoldelcentro.com.mx/cultura/",
            "Cuernavaca": "https://www.elsoldecuernavaca.com.mx/cultura/",
            "Puebla": "https://www.elsoldepuebla.com.mx/cultura/",
            "Tlaxcala": "https://www.elsoldetlaxcala.com.mx/cultura/",
            "Hidalgo": "https://www.elsoldehidalgo.com.mx/cultura/",
            "Hermosillo": "https://www.elsoldehermosillo.com.mx/cultura/",
            "Chihuahua":"https://www.elheraldodechihuahua.com.mx/cultura/",
            "Juárez":"https://www.elheraldodejuarez.com.mx/cultura/",
            "Durango":"https://www.elsoldedurango.com.mx/cultura/",
            "Parral":"https://www.elsoldeparral.com.mx/cultura/",
            "Zacatecas":"https://www.elsoldezacatecas.com.mx/cultura/",
            "Coahuila":"https://www.elsoldelalaguna.com.mx/cultura/",
            "Sonora":"https://www.tribunadesanluis.com.mx/cultura/",
            "Acapulco":"https://www.elsoldeacapulco.com.mx/cultura/",
            "Mazatlán":"https://www.elsoldemazatlan.com.mx/cultura/",
            "Sinaloa":"https://www.elsoldesinaloa.com.mx/cultura/",
            "Tijuana":"https://www.elsoldetijuana.com.mx/cultura/",
            "La Paz":"https://www.elsudcaliforniano.com.mx/cultura/",
            "Mexicali":"https://www.lavozdelafrontera.com.mx/cultura/"
        ]
        
        guard let url = URL(string: urls[state] ?? "") else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data for \(state): \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }

            DispatchQueue.global(qos: .background).async {
                do {
                    let html = String(data: data, encoding: .utf8)
                    print("Fetched HTML for \(state): \(html ?? "No HTML content")") // Debug HTML content

                    let document = try SwiftSoup.parse(html ?? "")
                    
                    // Use CSS selector for <h4> and <h2> tags containing <a> tags
                    let headlineElements = try document.select("h4.title > a, h2.title > a")
                    
                    if headlineElements.isEmpty {
                        print("No headlines found for \(state).")
                    }
                    
                    let headlines = try headlineElements.map { element -> Headline in
                        let headlineText = try element.text()
                        let link = try element.attr("href")
                        return Headline(title: headlineText, url: link)
                    }
                    
                    DispatchQueue.main.async {
                        completion(headlines)
                    }
                } catch {
                    print("Parsing error for \(state): \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }
        }.resume()
    }
}
