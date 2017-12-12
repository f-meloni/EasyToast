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
        
        describe("Display tests") {
            context("When show tost is called on a view", {
                it("dispays the toast") {
                    view.showToast("Toast", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
                    
                    expect(view.hasDisplayedToast) == true
                    expect(UIView.toastWindow).toNot(beNil())
                }
            })
            
            context("When many toasts are added with the same tag", {
                it("adds only the first toast to the queue") {
                    view.showToast("Toast", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
                    view.showToast("Toast2", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
                    view.showToast("Toast3", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
                    
                    expect(UIView.toastQueue.count) == 1
                }
            })
        }
    }
}
