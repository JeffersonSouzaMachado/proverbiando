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

            guard let verse = apiResponse.verses.first else {
                completion(nil)
                return
            }

            let proverb = Proverb(
                text: verse.text.trimmingCharacters(in: .whitespacesAndNewlines),
                chapter: verse.chapter,
                verse: verse.verse
            )

            completion(proverb)

        } catch {
            print("Erro ao decodificar:", error)
            completion(nil)
        }

    }.resume()
}
