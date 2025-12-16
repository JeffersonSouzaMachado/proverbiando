import Foundation

final class ApiService{
    
    func fetchProverbApi(  chapter: Int,
                              verse: Int,completion: @escaping (Proverb?) -> Void) {
        
        let urlString =
        "https://bible-api.com/proverbs+\(chapter):\(verse)?translation=almeida"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                completion(nil)
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(
                    BibleApiResponse.self,
                    from: data!
                )
                
                guard let verse = apiResponse.verses.first else {
                    completion(nil)
                    return
                }
                
                let proverb = Proverb(
                    text: verse.text.trimmingCharacters(in: .whitespacesAndNewlines),
                    chapter: verse.chapter,
                    verse: verse.verse,
                    analysis: " ",
                    application: " ",
                )
                
                completion(proverb)
                
            } catch {
                print("Erro ao decodificar:", error)
                completion(nil)
            }
            
        }.resume()
    }
}
