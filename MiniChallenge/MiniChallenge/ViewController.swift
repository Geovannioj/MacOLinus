//
//  ViewController.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let teacher = Teacher(name:"Julio Cezar", email:"Julio@bepid.com")
        let note = Note(title:"Aula de Orientacao a Objetos", description:"Nessa aula o professor Julio ensinou como funciona polimorfismo em Objective C", images:UIImage(named: "imagem.png")!)
        let subject = Subject(title:"Desenho", place:"Mocap", icon:UIImage(named: "imagem.png")!, schedule:Date(), color:UIColor.blue, teacher:teacher, note:note)
        
        print(teacher.name, teacher.email)
        print(note.title, note.description)
        print(subject.title, subject.place, subject.color, subject.schedule)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

