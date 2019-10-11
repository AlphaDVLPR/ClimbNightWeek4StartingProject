//
//  JRC_JokeTableViewCell.swift
//  ClimbNightWeek4
//
//  Created by AlphaDVLPR on 10/10/19.
//  Copyright © 2019 Jesse Rae. All rights reserved.
//

import UIKit

class JRC_JokeTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    //MARK: - Properties
    var joke: JRC_Joke? {
        didSet {
            updateViewsForJoke()
        }
    }
    
    //MARK: - Functions
    func updateViewsForJoke() {
        guard let joke = joke else {return}
        
        jokeLabel.text = joke.joke
        
        var combinedCategoriesString: String = ""
        for category in joke.categories {
            combinedCategoriesString += category + " "
        }
        categoryLabel.text = combinedCategoriesString
    }
}
