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
    @IBOutlet weak var jokesTableView: UITableView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var numberOfJokesLabel: UILabel!
    @IBOutlet weak var numberOfJokesSlider: UISlider!
    @IBOutlet weak var getJokesButton: UIButton!
    
    // MARK: - Properties
    var numberOfJokes: Int = 50
    var jokes: [JRC_Joke] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jokesTableView.rowHeight = 142
        self.jokesTableView.estimatedRowHeight = 142
        jokesTableView.delegate = self
        jokesTableView.dataSource = self
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
            DispatchQueue.main.async {
                if let jokes = jokes {
                    self.jokes = jokes
                    self.jokesTableView.reloadData()
                } else {
                    print("We got problems")
                }
            }
        }
    }
    
    // MARK: - Custom Functions
    
    func updateViews() {
        getJokesButton.layer.cornerRadius = getJokesButton.frame.height / 2
        
        numberOfJokesLabel.text = String(numberOfJokes)
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath) as? JRC_JokeTableViewCell else {return UITableViewCell()}
        
        cell.joke = jokes[indexPath.row]
        
        return cell
    }
    
    
}
