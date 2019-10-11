//
//  ViewController.swift
//  ProgrammaticUILab
//
//  Created by Anthony Gonzalez on 10/10/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ColorGuessModel = ColorGuessingModel()
    
    //MARK: -- Properties
    lazy var redButton: UIButton = {
        let button = UIButton()
        button.setTitle("Red", for: .normal)
        button.titleLabel?.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.showsTouchWhenHighlighted = true
        button.layer.cornerRadius = 10
        button.tag = 0
        button.addTarget(self, action: #selector(colorButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var greenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Green", for: .normal)
        button.titleLabel?.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        button.showsTouchWhenHighlighted = true
        button.layer.cornerRadius = 10
        button.tag = 1
        button.addTarget(self, action: #selector(colorButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var blueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Blue", for: .normal)
        button.titleLabel?.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        button.showsTouchWhenHighlighted = true
        button.layer.cornerRadius = 10
        button.tag = 2
        button.addTarget(self, action: #selector(colorButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var newGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Game", for: .normal)
        button.titleLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.showsTouchWhenHighlighted = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(newGameButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var currentScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var highScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var gameOverLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "GAME OVER"
        return label
    }()
    
    lazy var colorView: UIView = {
        let myView = UIView()
        myView.layer.cornerRadius = myView.frame.size.height/2
                myView.clipsToBounds = true
//        myView.layer.cornerRadius = 50
        myView.layer.borderWidth = 4.0
        myView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return myView
    }()
    
    //MARK: -- Methods
    
    @objc func newGameButtonPressed(sender: UIButton) {
        [newGameButton, gameOverLabel].forEach({$0?.isHidden = true})
        [redButton, greenButton, blueButton].forEach( { $0?.isHidden = false })
        colorView.backgroundColor = ColorGuessModel.changeColor()
        highScoreLabel.text = "Highscore: \(max(ColorGuessModel.myHighScore, ColorGuessModel.myCurrentScore))"
        ColorGuessModel.myCurrentScore = 0
        currentScoreLabel.text = "Current Score: 0"
    }
    
    
    @objc func colorButtonPressed(sender: UIButton){
        var guessOption: UIColor {
            switch sender.tag {
            case 0: return UIColor.red
            case 1: return UIColor.green
            case 2: return UIColor.blue
            default: return UIColor.black
            }
        }
        
        if ColorGuessModel.myClosestColorGuess(guessOption: guessOption) {
            currentScoreLabel.text = "Current Score: \(ColorGuessModel.myCurrentScore)"
            colorView.backgroundColor = ColorGuessModel.changeColor()
        } else {
            [newGameButton, gameOverLabel].forEach({$0?.isHidden = false})
            [redButton,greenButton,blueButton].forEach({$0?.isHidden = true})
        }
    }
    
    private func setUpSubViews(){
        [redButton, greenButton, blueButton, colorView, currentScoreLabel, highScoreLabel, newGameButton, gameOverLabel].forEach{$0.translatesAutoresizingMaskIntoConstraints = false }
        
        let UIElements = [redButton,greenButton,blueButton,colorView, currentScoreLabel, highScoreLabel, newGameButton, gameOverLabel]
        for UIElement in UIElements {
            self.view.addSubview(UIElement)
        }
    }

    
    private func setConstraints() {
        //Creates color button stack view
        let colorButtonStackView = UIStackView(arrangedSubviews: [redButton, greenButton, blueButton])
        colorButtonStackView.axis = .horizontal //Makes a horizontal stackView
        colorButtonStackView.spacing = 35
        colorButtonStackView.distribution = .fillEqually
        colorButtonStackView.alignment = .center
        
        //Creates score label stack view
        let scoreLabelStackView = UIStackView(arrangedSubviews: [highScoreLabel, currentScoreLabel, gameOverLabel])
        scoreLabelStackView.axis = .vertical
        scoreLabelStackView.spacing = 20
        scoreLabelStackView.distribution = .equalSpacing
        scoreLabelStackView.alignment = .center
        
        [scoreLabelStackView,colorButtonStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        view.addSubview(colorButtonStackView)
        view.addSubview(scoreLabelStackView)
        
        NSLayoutConstraint.activate([
            //Buttons
            colorButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorButtonStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            colorButtonStackView.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 5),
            colorButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
            
            //Score labels
            scoreLabelStackView.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),
            scoreLabelStackView.centerYAnchor.constraint(equalTo: colorView.centerYAnchor, constant: -250),
            
            //Color view
            colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 350),
            colorView.heightAnchor.constraint(equalToConstant: 350),
            
            //New Game Button
            newGameButton.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),
            newGameButton.centerYAnchor.constraint(equalTo: colorView.centerYAnchor),
            newGameButton.widthAnchor.constraint(equalToConstant: 150),
            newGameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
     private func setInitialLoadup() {
         self.view.backgroundColor = #colorLiteral(red: 0.8423173428, green: 0.9848207831, blue: 0.7865867019, alpha: 1)
         colorView.backgroundColor = ColorGuessModel.myCurrentColor
         highScoreLabel.text = "High Score: 0"
         currentScoreLabel.text = "Current Score: 0"
    
         gameOverLabel.isHidden = true
         newGameButton.isHidden = true
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setConstraints()
        setInitialLoadup()
    }
}



