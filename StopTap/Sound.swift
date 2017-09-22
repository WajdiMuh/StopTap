class Sound {
    
    var audioEffect : SystemSoundID = 0
    init(name : String, type: String) {
        let path  = NSBundle.mainBundle().pathForResource(name, ofType: type)!
        let pathURL = NSURL(fileURLWithPath: path)
        AudioServicesCreateSystemSoundID(pathURL as CFURLRef, &audioEffect)
    }
    
    func play() {
        AudioServicesPlaySystemSound(audioEffect)
    }
}
