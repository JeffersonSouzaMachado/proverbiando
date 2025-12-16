import Foundation

func fetchRandomProverb(completion: @escaping (Proverb?) -> Void) {
    
    let randomChapter = Int.random(in: 1...31)
    let randomVerse = Int.random(in: 1...33)
    
    let urlString =
    "https://bible-api.com/proverbs+\(randomChapter):\(randomVerse)?translation=almeida"
    
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
            
            guard let proverb = apiResponse.verses.first else {
                completion(nil)
                return
            }
            
            
            
            guard let text = proverb.text else {return completion(nil)}
            guard let chapter = proverb.chapter else {return completion(nil)}
            guard let verse = proverb.verse else {return completion(nil)}
          
            
            let proverbComplete = Proverb(
                text: text.trimmingCharacters(in: .whitespacesAndNewlines),
                chapter: chapter,
                verse:verse
            )
            
            completion(proverbComplete)
            
        } catch {
            print("Erro ao decodificar:", error)
            completion(nil)
        }
        
    }.resume()
}
