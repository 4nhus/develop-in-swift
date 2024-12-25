//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Anh Nguyen on 25/12/2024.
//

import UIKit

class QuestionViewController: UIViewController {
    var questions = [
        Question(
            text: "How do you usually make an impression?",
            type: .single,
            answers: [
                Answer(text: "I bring undeniable confidence and energy.", type: .willy),
                Answer(text: "I charm people with my smooth and effortless vibes.", type: .wet),
                Answer(text: "I turn heads everywhere I go—it's natural.", type: .gyat),
                Answer(text: "I stir things up and leave people blushing.", type: .devil)
            ].shuffled()
        ),
        Question(
            text: "What’s your favorite kind of attention?",
            type: .single,
            answers: [
                Answer(text: "The kind where people can’t stop thinking about me.", type: .willy),
                Answer(text: "The kind where I leave them wanting more.", type: .wet),
                Answer(text: "The kind where I’m the center of their fantasies.", type: .gyat),
                Answer(text: "The kind where I make them feel a little… bad, but in a good way.", type: .devil)
            ].shuffled()
        ),
        Question(
            text: "How would your friends describe your energy?",
            type: .single,
            answers: [
                Answer(text: "Big and bold—you’re hard to miss.", type: .willy),
                Answer(text: "Smooth and irresistible—you’ve got a way about you.", type: .wet),
                Answer(text: "Cheeky and flirty—you’re all about the tease.", type: .gyat),
                Answer(text: "Mischievous and spicy—you’re always stirring the pot.", type: .devil)
            ].shuffled()
        ),
        Question(
            text: "What’s your go-to vibe when flirting?",
            type: .multiple,
            answers: [
                Answer(text: "I go straight for the bold move.", type: .willy),
                Answer(text: "I keep it cool and leave them wanting more.", type: .wet),
                Answer(text: "I use my looks and charm to reel them in.", type: .gyat),
                Answer(text: "I drop spicy hints and watch them squirm.", type: .devil)
            ].shuffled()
        ),
        Question(
            text: "On a scale of 1 to ‘extra,’ how much attention do you attract?",
            type: .ranged,
            answers: [
                Answer(text: "I don’t need to show off.", type: .willy),
                Answer(text: "I bring some energy, but it’s all natural.", type: .wet),
                Answer(text: "I’m turning heads wherever I go.", type: .gyat),
                Answer(text: "I thrive as the center of spicy drama.", type: .devil)
            ]
        ),
        Question(
            text: "What’s your secret weapon in a group setting?",
            type: .single,
            answers: [
                Answer(text: "My big personality and boldness.", type: .willy),
                Answer(text: "My cool, irresistible vibes.", type: .wet),
                Answer(text: "My charm and irresistible presence.", type: .gyat),
                Answer(text: "My mischievous and spicy energy.", type: .devil)
            ].shuffled()
        )
    ].shuffled()
    var questionIndex = 0
    var answersChosen = [Answer]()
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multiLabel1: UILabel!
    @IBOutlet var multiLabel2: UILabel!
    @IBOutlet var multiLabel3: UILabel!
    @IBOutlet var multiLabel4: UILabel!
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    @IBOutlet var rangedSlider: UISlider!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(with: currentAnswers)
        case .multiple:
            updateMultipleStack(with: currentAnswers)
        case .ranged:
            updateRangedStack(with: currentAnswers)
        }
    }
    
    func updateSingleStack(with answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(with answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(with answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(rangedSlider.value * Float(currentAnswers.count - 1))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
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
