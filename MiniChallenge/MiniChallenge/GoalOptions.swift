//
//  GoalOptions.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 11/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class GoalOptions: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "HomeGoal", sender: Any?.self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "studyForTest" {
            
            if let toCreateUserGoal = segue.destination as? CreateGoal {
                toCreateUserGoal.goalType = "Estudar para a prova"
            }
        } else if segue.identifier == "startAProject" {
            if let toCreateUserGoal = segue.destination as? CreateGoal {
                toCreateUserGoal.goalType = "Começar o projeto"
            }
            
        } else if segue.identifier == "readABook" {
            if let toCreateUserGoal = segue.destination as? CreateGoal {
                toCreateUserGoal.goalType = "Ler o Livro"
            }
        } else if segue.identifier == "customGoal" {
            if let toCreateUserGoal = segue.destination as? CreateGoal {
                toCreateUserGoal.goalType = ""
            }
        }else if segue.identifier == "HomeGoal"{
            CalendarViewController.pushedFromHomeGoal = true
        }
    }

    @IBAction func studyForTestPressed(_ sender: Any) {
        performSegue(withIdentifier: "studyForTest", sender: Any?.self)
    }

    @IBAction func startingAProjectPressed(_ sender: Any) {
        performSegue(withIdentifier: "startAProject", sender: Any?.self)
    }

    @IBAction func readABookPressed(_ sender: Any) {
        performSegue(withIdentifier: "readABook", sender: Any?.self)
    }
    
    @IBAction func customGoalPressed(_ sender: Any) {
        performSegue(withIdentifier: "customGoal", sender: Any?.self)
    }
}
