import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    // 1. 拖拽生成控件的outlet
    @IBOutlet weak var segmented: UISegmentedControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var firstTableView: UITableView!
    
    @IBOutlet weak var secondTableView: UITableView!
    
    // 5. 定义一个变量来记录scrollview的内容偏移量
    var offset: CGFloat = 0.0 {
        
        // 当offset的值改变后会执行didSet代码块
        didSet {
            UIView.animateWithDuration(0.3) { () -> Void in
                self.scrollView.contentOffset = CGPoint(x: self.offset, y: 0.0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        firstTableView.dataSource = self
        secondTableView.dataSource = self
        
        // 6. 为scrollView增加滑动手势识别器
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeLeft.direction = .Left
        swipeLeft.numberOfTouchesRequired = 1
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeRight.direction = .Right
        swipeRight.numberOfTouchesRequired = 1
        
        scrollView.addGestureRecognizer(swipeLeft)
        scrollView.addGestureRecognizer(swipeRight)
    }
    
    // 2. 当Segmented Control选择的item改变时,会触发这个Action
    @IBAction func tabChanged(sender: AnyObject) {
        // a. 获取到当前item的下标
        let index = (sender as! UISegmentedControl).selectedSegmentIndex
        
        // b. 设置scrollview的内容偏移量
        offset = CGFloat(index) * self.view.frame.width
    }
    
    // 3. 隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // 4. 为TableView填充数据
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reusedID: String!
        
        if tableView.tag == 101 {
            reusedID = "first"
        }
        else {
            reusedID = "second"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reusedID) as UITableViewCell!
        
        if tableView.tag == 101 {
            cell.textLabel!.text = "第一个TableView"
        }
        else {
            cell.textLabel!.text = "第二个TableView"
        }
        
        return cell
    }
    
    // 滑动手势处理函数
    func swipe(gesture: UISwipeGestureRecognizer) {
        
        if gesture.direction == .Left {
            // 想左滑时展示第二个tableview,同时设置选中的segmented item
            offset = self.view.frame.width
            segmented.selectedSegmentIndex = 1
        }
        else {
            offset = 0.0
            segmented.selectedSegmentIndex = 0
        }
    }
    
}

