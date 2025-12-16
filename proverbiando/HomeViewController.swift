//
//  HomeViewController.swift
//  proverbiando
//
//  Created by Jefferson Machado on 15/12/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var proverbLabel: UILabel!
    
    @IBOutlet weak var referenceLabel: UILabel!
    
    
    @IBAction func updateProverb(_ sender: Any) {
        
        fetchProverbs()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configLayout()
        fetchProverbs()
    }
    
    func configLayout(){
        navigationItem.hidesBackButton = true
    }
    
    func fetchProverbs(){
        fetchRandomProverb { proverb in
            guard let proverb = proverb else { return }
            
            DispatchQueue.main.async {
                self.proverbLabel.text = proverb.text
                self.referenceLabel.text = "Provérbios \(proverb.chapter):\(proverb.verse)"
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
