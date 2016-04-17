//
//  ViewController.swift
//  reproductor
//
//  Created by Pilar on 17/04/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var portada: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    
    private var reproductor: AVAudioPlayer!
    
    let bachURL = NSBundle.mainBundle().URLForResource("Bach, J.S. violin concerto in E major BWV 1042", withExtension: "mp3")
    let bethovenURL = NSBundle.mainBundle().URLForResource("Symphony No 9 in D minor Op 125 (the Choral) Scherzo Molto vivace – Presto (D minor)", withExtension: "mp3")
    let mozartURL = NSBundle.mainBundle().URLForResource("Eine kleine Nachtmusik (Serenade No 13 for strings in G major)", withExtension: "mp3")
    let tchaikovskyURL = NSBundle.mainBundle().URLForResource("Swan Lake, Op 20 Act II X Scène Moderato", withExtension: "mp3")
    let vivaldiURL = NSBundle.mainBundle().URLForResource("Concerto No 1 in E major, Op 8, RV 269, \"La primavera\"", withExtension: "mp3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try reproductor = AVAudioPlayer(contentsOfURL: bachURL!)
        } catch {
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pause() {
        if reproductor.playing {
            reproductor.pause()
        }
    }

    @IBAction func play() {
        if !reproductor.playing {
            if titulo.text == "" {
                titulo.text = "Violin concerto in E major BWV 1042"
                portada.image = UIImage(named: "bach")
            }
            reproductor.play()
        }
    }
    
    @IBAction func stop() {
        if reproductor.playing {
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
    }
    
    @IBAction func volume(sender: UISlider) {
        reproductor.volume = sender.value / 100.0;
    }
    
    @IBAction func random() {
        let random = Int(arc4random_uniform(UInt32(5)))
        switch random {
        case 0:
            playBach()
        case 1:
            playBethoven()
        case 2:
            playMozart()
        case 3:
            playTchaokovsky()
        case 4:
            playVivaldi()
        default:
            playBach()
        }
    }
    
    @IBAction func playBach() {
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: bachURL!)
        } catch {
            print("error")
        }
        titulo.text = "Violin concerto in E major BWV 1042"
        portada.image = UIImage(named: "bach")
        stop()
        play()
    }
    
    @IBAction func playBethoven() {
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: bethovenURL!)
        } catch {
            print("error")
        }
        titulo.text = "Symphony No 9 in D minor Op 125 (the Choral) Scherzo Molto vivace – Presto (D minor)"
        portada.image = UIImage(named: "bethoven")
        stop()
        play()
    }
    
    @IBAction func playMozart() {
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: mozartURL!)
        } catch {
            print("error")
        }
        titulo.text = "Eine kleine Nachtmusik (Serenade No 13 for strings in G major)"
        portada.image = UIImage(named: "mozart")
        stop()
        play()
    }
    
    @IBAction func playTchaokovsky() {
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: tchaikovskyURL!)
        } catch {
            print("error")
        }
        titulo.text = "Swan Lake, Op 20 Act II X Scène Moderato"
        portada.image = UIImage(named: "tchaikovsky")
        stop()
        play()
    }
    
    @IBAction func playVivaldi() {
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: vivaldiURL!)
        } catch {
            print("error")
        }
        titulo.text = "Concerto No 1 in E major, Op 8, RV 269, \"La primavera\""
        portada.image = UIImage(named: "vivaldi")
        stop()
        play()
    }
    
    
    
}

