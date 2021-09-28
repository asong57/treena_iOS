//
//  ViewController.swift
//  treena
//
//  Created by asong on 2021/09/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func mypageButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MyPageVC") as? MyPageViewController else {return}
      
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PlusVC") as? PlusViewController else {return}
      
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func calendarButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CalendarVC") as? CalendarViewController else {return}
      
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

