//
//  MainViewController.swift
//  ClimbNightWeek4
//
//  Created by Jackson Tubbs on 10/10/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var numberOfJokesLabel: UILabel!
    @IBOutlet weak var numberOfJokesSlider: UISlider!
    @IBOutlet weak var getJokesButton: UIButton!
    
    // MARK: - Properties
    var numberOfJokes: Int = 50
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func numberOfJokesSliderChanged(_ sender: UISlider) {
        numberOfJokes = Int(round(sender.value))
        numberOfJokesLabel.text = String(numberOfJokes)
    }
    
    @IBAction func getJokesButtonTapped(_ sender: Any) {
        
        guard let firstNameText = firstNameTextField.text, firstNameText.isEmpty == false,
            let lastNameText = lastNameTextField.text, lastNameText.isEmpty == false else {return}
        
        JRC_JokeNetworkCalls.fetchJoke(withFirstName: firstNameTextField.text, lastName: lastNameTextField.text, numberOfJokes: numberOfJokes) { (jokes) in
            
            if let jokes = jokes {
                print("We got jokes")
            } else {
                print("We got problems")
            }
        }
    }

    // MARK: - Custom Functions
    
    func updateViews() {
        getJokesButton.layer.cornerRadius = getJokesButton.frame.height / 2
        
        numberOfJokesLabel.text = String(numberOfJokes)
    }
}
