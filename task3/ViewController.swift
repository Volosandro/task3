//
//  ViewController.swift
//  task3
//
//  Created by Volosandro on 31.10.2022.
//

import UIKit

class ViewController: UIViewController {

    var textLabel: UILabel!
    var button: UIButton!
    var timer: Timer?
    var counter: Int = 0 {
        didSet {
            self.setText("Текущее значение:\n\(self.counter)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addLabel()
        self.addButton()
        self.counter = 0
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(startCounter),
                                               name: Notification.Name("didEnterBackground"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stopCounter),
                                               name: Notification.Name("didEnterForeground"),
                                               object: nil)
        
        LocationManager.shared.startLocationUpdate()
    }

    func addLabel()
    {
        self.textLabel = UILabel(frame: .zero)
        self.textLabel.textColor = .black
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel.textAlignment = .center
        self.textLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.textLabel.numberOfLines = 2
        
        self.view.addSubview(self.textLabel)
        
        let leftConstraints = NSLayoutConstraint(item: self.view!,
                                                 attribute: .leading,
                                                 relatedBy: .equal,
                                                 toItem: self.textLabel,
                                                 attribute: .leading,
                                                 multiplier: 1,
                                                 constant: -20)
        
        let rightConstraints = NSLayoutConstraint(item: self.view!,
                                                  attribute: .trailing,
                                                  relatedBy: .equal,
                                                  toItem: self.textLabel,
                                                  attribute: .trailing,
                                                  multiplier: 1,
                                                  constant: 20)
        
        let centerConstraint = NSLayoutConstraint(item: self.view!,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: self.textLabel,
                                                  attribute: .centerY,
                                                  multiplier: 1,
                                                  constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: self.textLabel!,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .height,
                                                  multiplier: 1,
                                                  constant: 100)
        
        self.view.addConstraints([leftConstraints, rightConstraints, centerConstraint, heightConstraint])
    }
    
    func addButton()
    {
        self.button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        self.button.backgroundColor = .blue
        self.button.setTitleColor(.white, for: .normal)
        self.button.setTitle("Сбросить", for: .normal)
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.addTarget(self,
                              action: #selector(resetCounter),
                              for: .touchUpInside)
        self.view.addSubview(self.button)
        
        let centerConstraint = NSLayoutConstraint(item: self.view!,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: self.button,
                                                  attribute: .centerX,
                                                  multiplier: 1,
                                                  constant: 0)
        
        let topConstraint = NSLayoutConstraint(item: self.button!,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.textLabel,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 0)
        
        self.view.addConstraints([centerConstraint, topConstraint])
    }

    func setText(_ text: String)
    {
        self.textLabel.text = text
    }
    
    @objc func resetCounter()
    {
        self.counter = 0
    }
    
    @objc func doIncrement()
    {
        self.counter += 1
    }
    
    @objc func startCounter() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                          target: self,
                                          selector: #selector(doIncrement),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    @objc func stopCounter()
    {
        if let timer = timer, timer.isValid {
            timer.invalidate()
        }
    }
}

