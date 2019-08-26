

import UIKit
import paper_onboarding


class OnBoardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    @IBOutlet weak var getstartedButton: UIButton!
    @IBAction func getstartedButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboarding complete")
        userDefaults.synchronize()
    }
    @IBOutlet weak var onboardingView: OnBoardingview!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.dataSource = self
        onboardingView.delegate = self
    }

    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 23)
        let descrriptionfont = UIFont(name: "AvenirNext-Regular", size: 12)
        
        return [
            OnboardingItemInfo(informationImage: UIImage(named: "Idle")!,
                               title: "No login required",
                               description: "They're using our own satellites against us. And the clock is ticking. Eventually, you do plan to have dinosaurs on your dinosaur tour, right? Hey, take a look at the earthlings. Goodbye! God creates dinosaurs. God destroys dinosaurs. God creates Man. Man destroys God. Man creates Dinosaurs.",
                               pageIcon: UIImage(named: "small")!,
                               color: UIColor.yellow,
                               titleColor: UIColor.blue,
                               descriptionColor: UIColor.blue,
                               titleFont: titleFont!,
                               descriptionFont: descrriptionfont!, descriptionLabelPadding: 30),
            
            OnboardingItemInfo(informationImage: UIImage(named: "Jump")!,
                               title: "Allow notifications",
                               description: "What do they got in there? King Kong? My dad once told me, laugh and the world laughs with you, Cry, and I'll give you something to cry about you little bastard! God creates dinosaurs. God destroys dinosaurs. God creates Man. Man destroys God. Man creates Dinosaurs.",
                               pageIcon: UIImage(named: "small")!,
                               color: UIColor.red,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: titleFont!,
                               descriptionFont: descrriptionfont!, descriptionLabelPadding: 30),

            OnboardingItemInfo(informationImage: UIImage(named: "JumpShoot")!,
                               title: "Simple notes",
                               description: "Checkmate... Checkmate... So you two dig up, dig up dinosaurs? I gave it a cold? I gave it a virus. A computer virus. I was part of something special. Must go faster. Jaguar shark! So tell me - does it really exist? Yeah, but John, if The Pirates of the Caribbean breaks down, the pirates don’t eat the tourists.",
                               pageIcon: UIImage(named: "small")!,
                               color: UIColor.blue,
                               titleColor: UIColor.yellow,
                               descriptionColor: UIColor.yellow,
                               titleFont: titleFont!,
                               descriptionFont: descrriptionfont!, descriptionLabelPadding: 30)
            ][index]
    }
    


    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index _: Int) {
        
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            UIView.animate(withDuration: 0.4) {
                self.getstartedButton.alpha = 1
            }
        }
    }

    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1 {
            if self.getstartedButton.alpha == CGFloat(1) {
                UIView.animate(withDuration: 0.4) {
                    self.getstartedButton.alpha = 0
                }
            }
        }
    }


}


extension UIColor {
    
    static let bgColorOne = UIColor(red:0.36, green:0.73, blue:0.44, alpha:1.0)
    static let bgColorTwo = UIColor(red:0.24, green:0.64, blue:0.30, alpha:1.0)
    static let bgColorThree = UIColor(red:0.16, green:0.57, blue:0.20, alpha:1.0)
    static let blue = UIColor(red: 1.0/255.0, green: 100.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let white = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)

    
}
