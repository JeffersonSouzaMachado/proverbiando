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
    
    @IBOutlet weak var updateProberbButton: UIButton!
    
    var activityIndicator: UIActivityIndicatorView!

    
    @IBAction func updateProverb(_ sender: Any) {
        
        fetchProverbs()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initLoading()
        configLayout()
        fetchProverbs()
    }
    
    
    
    func configLayout(){
        navigationItem.hidesBackButton = true
    }
    
    func fetchProverbs(){
        self.startLoading()
        fetchRandomProverb { proverb in
            guard let proverb = proverb else { return }
            
            let chapter = proverb.chapter ?? 0
            let verse = proverb.verse ?? 0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.proverbLabel.text = proverb.text
                self.referenceLabel.text = "Provérbios \(chapter):\(verse)"
                self.stopLoading()
            }
        }
    }
    
    func initLoading(){
        // Inicializando o Activity Indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center // Posiciona o spinner no centro da tela
        activityIndicator.hidesWhenStopped = true // Esconde quando parar
        view.addSubview(activityIndicator)

    }
    
    func startLoading(){
        proverbLabel.isHidden = true
        referenceLabel.isHidden = true
        updateProberbButton.isHidden = true
        
        activityIndicator.startAnimating()
    }
    
    func stopLoading(){
        proverbLabel.isHidden = false
        referenceLabel.isHidden = false
        updateProberbButton.isHidden = false
        
        activityIndicator.stopAnimating()
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
