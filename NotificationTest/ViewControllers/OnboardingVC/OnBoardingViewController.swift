

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
        
        let titleFont = UIFont(name: "Avenir Next", size: 23)
        let descrriptionfont = UIFont(name: "Avenir Next", size: 15)
        
        return [
            OnboardingItemInfo(informationImage: UIImage(named: "MyDJ_White")!,
                               title: "Easy notes!",
                               description: "Make daily notes and keep them in safe place.",
                               pageIcon: UIImage(named: "small")!,
                               color: UIColor.bgColorOne,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: titleFont!,
                               descriptionFont: descrriptionfont!, descriptionLabelPadding: 30),
            
            OnboardingItemInfo(informationImage: UIImage(named: "cloud")!,
                               title: "No login required",
                               description: "Your data is saved on your iCloud account. This enables you to keep your data even if you change device.",
                               pageIcon: UIImage(named: "small")!,
                               color: UIColor.bgColorTwo,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: titleFont!,
                               descriptionFont: descrriptionfont!, descriptionLabelPadding: 30),

            OnboardingItemInfo(informationImage: UIImage(named: "privacy")!,
                               title: "Simple notes, Easy access",
                               description: "Your data is kept private for you. No one else can access the data you provide in the DailyJournal app.",
                               pageIcon: UIImage(named: "small")!,
                               color: UIColor.bgColorFive,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
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



