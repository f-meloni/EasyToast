import Quick
import Nimble
@testable import EasyToast

class EasyToastTests: QuickSpec {
    override func spec() {
        describe("Display test") {
            context("Display a toast on a new view", {
                let view = UIView()
                
                view.showToast("Toast", position: .Bottom, popTime: kToastNoPopTime, dismissOnTap: false)
                
                it("Toast has been displayed") {
                    expect(view.hasDisplayedToast).to(beTruthy())
                    expect(UIView.toastWindow).toNot(beNil())
                }
            })
        }
    }
}