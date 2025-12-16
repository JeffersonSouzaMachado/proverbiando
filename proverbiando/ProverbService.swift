//
//  ProverbService.swift
//  proverbiando
//
//  Created by Jefferson Machado on 16/12/25.
//





final class ProverbService {
    private let apiService = ApiService()
    private let firebaseService = FirebaseService()
    
    
    
    func generateChapterAndVerse() -> (chapter: Int, verse: Int) {
        
        let versesPerChapter: [Int: Int] = [
            1: 33, 2: 22, 3: 35, 4: 27, 5: 23, 6: 35,
            7: 27, 8: 36, 9: 18, 10: 32, 11: 31, 12: 28,
            13: 25, 14: 35, 15: 33, 16: 33, 17: 28, 18: 24,
            19: 29, 20: 30, 21: 31, 22: 29, 23: 35, 24: 34,
            25: 28, 26: 28, 27: 27, 28: 28, 29: 27, 30: 33,
            31: 31
        ]
        
        let chapter = Int.random(in: 1...31)
        let maxVerse = versesPerChapter[chapter] ?? 1
        
        let verse: Int
        if chapter == 1 {
            verse = Int.random(in: 7...maxVerse)
        } else {
            verse = Int.random(in: 1...maxVerse)
        }
        
        return (chapter: chapter, verse: verse)
    }
    
    
    
    func getProverb(
        chapter: Int,
        verse: Int,
        completion: @escaping (Proverb) -> Void
    ) {
        
        firebaseService.fetchProverb(
            chapter: chapter,
            verse: verse
        ) { [weak self] cachedProverb in
            
            if let cachedProverb = cachedProverb {
                completion(cachedProverb)
                return
            }
            
            self?.apiService.fetchProverbApi(
                chapter: chapter,
                verse: verse,
            ){ apiProverb in
                guard let apiProverb = apiProverb else {return}
                
                self?.firebaseService.saveProverb(apiProverb)
                
                completion(apiProverb)
                
            }
        }
    }
    //PROX PASSO, CHAMAR NA TELA O PROVERBIO
    //SALVAR NO FIREBASE O QUE TEM
    //INTEGRAR A LLM PARA ANALISE E APLICAÇÃO
}
