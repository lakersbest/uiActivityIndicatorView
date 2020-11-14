import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var count = 0
    
    /* 一開始設定倒數開始數字，並顯示在畫面上 */
    override func viewDidLoad() {
        super.viewDidLoad()
        resetLabel()
    }
    
    /* 將lbNumber上的數字回復為9 */
    func resetLabel() {
        count = 10
        lbNumber.text = String(count)
    }
    
    /* 檢查若activityIndicatorView沒有播放動畫，回復初始設定並開始播放動畫直到倒數完畢 */
    @IBAction func countDownClick(_ sender: Any) {
        if !activityIndicatorView.isAnimating {
            resetLabel()
            activityIndicatorView.startAnimating()
            /* 設定計時器不間斷地(repeats: true)每隔1秒鐘(timeInterval: 1)就透過現行物件(target: self)呼叫selector所指定的timerFireMethod方法一次。selector方法應具備timerFireMethod(timer: Timer)型式，而且呼叫scheduledTimer()回傳的timer會將自己當作參數來傳遞，可以利用userInfo將資料帶給timerFireMethod，參看 scheduledTimer()說明 */
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFireMethod(timer:)), userInfo: "info", repeats: true)
        }
    }
    
    /* 檢查倒數數字count是否已達0，如果「count > 0」代表倒數尚未結束，繼續倒數並顯示count值與activityIndicatorView；如果count已達0代表倒數結束，將lbNumber清空 */
    @objc func timerFireMethod(timer: Timer) {
        print("timer.userInfo: \(timer.userInfo!)")
        if count > 0 {
            count -= 1
            lbNumber.text = String(count)
        } else {
            /* 清空lbNumber上面的值 */
            lbNumber.text = ""
            /* 如果有勾選「Hide When Stopped」屬性，倒數結束則自動隱藏 */
            activityIndicatorView.stopAnimating()
            /* 停止並移除timer計時器 */
            timer.invalidate()
        }
    }
}

