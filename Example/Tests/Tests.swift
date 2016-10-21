import Quick
import Nimble
@testable import EasyToast

class EasyToastTests: QuickSpec {
    override func spec() {
        beforeEach {
            UIView.toastQueue = []
            UIView.dismissToast()
        }
        
        let view = UIView()
        
        describe("Display test") {
            context("Display a toast on a new view", {
                
                
                it("Toast has been displayed") {
                    view.showToast("Toast", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
                    
                    expect(view.hasDisplayedToast).to(beTruthy())
                    expect(UIView.toastWindow).toNot(beNil())
                }
            })
            
            context("Toast tag test", {
                it("Only one toast is added") {
                    view.showToast("Toast", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
                    view.showToast("Toast2", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
                    view.showToast("Toast3", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
                    
                    expect(UIView.toastQueue.count) == 1
                }
            })
        }
    }
}
