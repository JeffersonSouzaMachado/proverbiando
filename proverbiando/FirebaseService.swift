//
//  FirebaseService.swift
//  proverbiando
//
//  Created by Jefferson Machado on 16/12/25.
//

import FirebaseFirestore

final class FirebaseService {

    private let db = Firestore.firestore()

    func fetchProverb(
        chapter: Int,
        verse: Int,
        completion: @escaping (Proverb?) -> Void
    ) {

        let documentId = "\(chapter)_\(verse)"

        db.collection("proverbs")
            .document(documentId)
            .getDocument { snapshot, error in

                if let data = snapshot?.data(),
                   let text = data["text"] as? String,
                   let analysis = data["analysis"] as? String,
                   let application = data["application"] as? String {

                    let proverb = Proverb(
                        text: text,
                        chapter: chapter,
                        verse: verse,
                        analysis: analysis,
                        application: application
                    )

                    completion(proverb)
                } else {
                    completion(nil)
                }
            }
    }

    func saveProverb(_ proverb: Proverb) {

        let documentId = "\(proverb.chapter)_\(proverb.verse)"

        let data: [String: Any] = [
            "text": proverb.text,
            "chapter": proverb.chapter,
            "verse": proverb.verse,
            "analysis": proverb.analysis,
            "application": proverb.application,
            "createdAt": Timestamp()
        ]

        db.collection("proverbs")
            .document(documentId)
            .setData(data)
    }
}
