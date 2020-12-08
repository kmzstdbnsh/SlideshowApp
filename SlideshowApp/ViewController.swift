//
//  ViewController.swift
//  SlideshowApp
//
//  Created by kazuto masuda on 2020/12/01.
//  Copyright © 2020 kmzstdbnsh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Base: UIView!
    @IBOutlet weak var imageArea: UIImageView!
    @IBOutlet weak var ForwardButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var PlayStopButton: UIButton!
    @IBOutlet weak var imageNumber: UILabel!
    
    //進むボタン
    @IBAction func onForwardButton(_ sender: Any) {
        if self.timer == nil {
            if imageNo < imageNameArray.count-1 {
                imageNo += 1
            }
            else {
                imageNo = 0
            }
            if imageNo > 3 {
                Base.backgroundColor = baseColor2
            }
            else {
                Base.backgroundColor = baseColor
            }
            ForwardButton.backgroundColor = onButtonColor
            imageNumber.text = "\(imageNo+1)/\(imageNameArray.count)"
            displayImage()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.ForwardButton.backgroundColor = self.offButtonColor
            }
        }
    }
    
    //戻るボタン
    @IBAction func onBackButton(_ sender: Any) {
        if self.timer == nil {
            if imageNo > 0 {
                imageNo -= 1
            }
            else {
                imageNo = imageNameArray.count-1
            }
            if imageNo > 3 {
                Base.backgroundColor = baseColor2
            }
            else {
                Base.backgroundColor = baseColor
            }
            BackButton.backgroundColor = onButtonColor
            imageNumber.text = "\(imageNo+1)/\(imageNameArray.count)"
            displayImage()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.BackButton.backgroundColor = self.offButtonColor
            }
        }
    }
    
    //再生/停止ボタン
    @IBAction func onPlayStopButton(_ sender: Any) {
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(displayImage2), userInfo: nil, repeats: true)
            PlayStopButton.backgroundColor = onButtonColor
            ForwardButton.setTitleColor( buttonTextColor2, for: .normal )
            BackButton.setTitleColor( buttonTextColor2, for: .normal )
            PlayStopButton.setTitle("停止", for: .normal)
        }
        else {
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // startTimer() の self.timer == nil で判断するために、 self.timer = nil としておく
            PlayStopButton.backgroundColor = offButtonColor
            ForwardButton.setTitleColor( buttonTextColor, for: .normal )
            BackButton.setTitleColor( buttonTextColor, for: .normal )
            PlayStopButton.setTitle("再生", for: .normal)
        }
        
    }
    
    @IBAction func TapImage(_ sender: Any) {
        if self.timer != nil {
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // startTimer() の self.timer == nil で判断するために、 self.timer = nil としておく
            PlayStopButton.backgroundColor = offButtonColor
            ForwardButton.setTitleColor( buttonTextColor, for: .normal )
            BackButton.setTitleColor( buttonTextColor, for: .normal )
            PlayStopButton.setTitle("再生", for: .normal)
        }
        performSegue(withIdentifier: "toEnlargedView",sender: nil)
    }
    
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    //画像
    var imageNo : Int = 0
    
    let imageNameArray = [
    "kadai3Image1",
    "kadai3Image2",
    "kadai3Image3",
    "kadai3Image4",
    "kadai3Image5",
    "kadai3Image6"
    ]
    
    //タイマー
    var timer: Timer!
    
    //色
    let baseColor = UIColor(red:0.2, green:0.1, blue:0.8, alpha:1.0)
    let baseColor2 = UIColor(red:1.0, green:0.2, blue:0.22, alpha:1.0)
    let buttonTextColor =  UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)
    let buttonTextColor2 =  UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.4)
    let onButtonColor = UIColor(red:0, green:0, blue:0, alpha:1.0)
    let offButtonColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
    
    
    //画像を表示するメソッド
    func displayImage() {
        imageArea.image = UIImage(named: imageNameArray[imageNo])
    }
    
    //自動再生用画像表示メソッド
    @objc func displayImage2(){
        if imageNo < imageNameArray.count-1 {
            imageNo += 1
        }
        else {
            imageNo = 0
        }
        if imageNo > 3 {
            Base.backgroundColor = baseColor2
        }
        else {
            Base.backgroundColor = baseColor
        }
        imageArea.image = UIImage(named: imageNameArray[imageNo])
        imageNumber.text = "\(imageNo+1)/\(imageNameArray.count)"
        /*if imageNo == imageNameArray.count-1 {
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil
            PlayStopButton.backgroundColor = offButtonColor
        }*/
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ForwardButton.backgroundColor = offButtonColor
        ForwardButton.setTitleColor( buttonTextColor, for: .normal )
        BackButton.backgroundColor = offButtonColor
        BackButton.setTitleColor( buttonTextColor, for: .normal )
        PlayStopButton.backgroundColor = offButtonColor
        PlayStopButton.setTitleColor( buttonTextColor, for: .normal )
        PlayStopButton.setTitle("再生", for: .normal)
        Base.backgroundColor = baseColor
        imageArea.image = UIImage(named: "kadai3Image1")
        imageNumber.text = "\(imageNo+1)/\(imageNameArray.count)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let enlargedViewController:EnlargedViewController = segue.destination as! EnlargedViewController

        if imageNo > 3 {
            enlargedViewController.baseColor = baseColor2
        }
        else {
            enlargedViewController.baseColor = baseColor
        }
        enlargedViewController.imageName = imageNameArray[imageNo]
    }
    
    
    
}

/*
(✓)プロジェクトを新規作成し、 SlideshowApp というプロジェクト名をつけてください
(✓)画面を2つ作成してください
()1つ目の画面ではスライドショー, 2つ目の画面では拡大画像を表示します
(✓)画像をプロジェクトに登録
()画像を定数として宣言
()画像を配列にほりこむ？
()
()
()
()
()
()スライドショー画面には、画像と3つのボタン（進む、戻る、再生/停止）を配置してください
()進むボタンで1つ先の画像を表示し、戻るボタンで1つ前の画像を表示します
()最後の画像の表示時に、進むボタンをタップすると、最初の画像が表示されるようにしてください
()最初の画像の表示時に、戻るボタンをタップすると、最後の画像が表示されるようにしてください
()再生ボタンをタップすると自動送りが始まり、2秒毎にスライドさせてください
()自動送りの間は、進むボタンと戻るボタンはタップ不可にしてください
()再生ボタンをタップすると停止ボタンになり、停止ボタンをタップすると再生ボタンにしてください
()停止ボタンをタップすると自動送りが止まり、進むボタンと戻るボタンをタップ可能にしてください
()画像をタップすると画面を遷移させ、拡大画像と戻るボタンを表示させてください
()戻るボタンがタップされると、スライドショー画面に戻り、同じ画像を表示してください
()Auto Layoutを使用して、iPhone 8, iPhone 8 Plus, iPhone 11, iPhone 11 Proの各画面サイズでレイアウトが崩れないようにしてください
()画像は、Xcodeのナビゲーションエリア（Project Navigator）へドラッグアンドドロップし、Copy items if neededにチェックを入れて、Xcodeプロジェクトへコピーしてください
()
()
()
()
()
()
*/


