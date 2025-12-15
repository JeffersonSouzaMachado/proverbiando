import Foundation

func fetchRandomProverb(completion: @escaping (Proverb?) -> Void) {
    let urlString = "https://api.biblia.com/v1/bible/verse?version=1&random=true" // Substitua pela URL real da API
    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Erro ao fazer a requisição: \(error)")
            completion(nil)
            return
        }
        
        guard let data = data else {
            print("Dados ausentes.")
            completion(nil)
            return
        }
        
        // Decodifica os dados da API para a estrutura Proverb
        do {
            let proverb = try JSONDecoder().decode(Proverb.self, from: data)
            completion(proverb)
        } catch {
            print("Erro ao decodificar os dados: \(error)")
            completion(nil)
        }
    }
    
    task.resume()
}
