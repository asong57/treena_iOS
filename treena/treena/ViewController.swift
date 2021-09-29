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
        
        setEmotionImage()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func mypageButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MyPageVC") as? MyPageViewController else {return}
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PlusVC") as? PlusViewController else {return}
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func calendarButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CalendarVC") as? CalendarViewController else {return}
      
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    func setEmotionImage(){
        let url = URL(string:         "https://postfiles.pstatic.net/MjAyMTA3MjlfNjcg/MDAxNjI3NTY4NjE3MzYw.Pjru3AoxNWqDOIhv6Nou9r2L6nSphVWNEMey3v-5704g.Q431roZ5UeD_2te-GnJ1mWERCiYqXgOnvqk9LhC3fbwg.JPEG.hahahafb/wood6.jpg?type=w966")
        do {
            let data = try Data(contentsOf: url!)
            imageView.image = UIImage(data: data)
        } catch {
            
        }
    }
}

