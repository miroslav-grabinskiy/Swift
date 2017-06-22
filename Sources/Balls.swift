import UIKit



public class Balls:UIView
{
    private var colors: [UIColor]
    
    private var balls: [UIView] = []
    
    private var ballSize: CGSize = CGSize(width:40,height:40)
    private var animator:UIDynamicAnimator?
    
    private var snapBehavior: UISnapBehavior?
    public init(colors: [UIColor])
    {
        self.colors = colors
        super.init(frame: CGRect(x:0,y:0,width:400,height:400))
        backgroundColor = UIColor.blue
        animator = UIDynamicAnimator(referenceView: self)
        ballsView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func ballsView()
    {
        for (index,color) in colors.enumerated()
        {
            let ball = UIView(frame: CGRect.zero)
            
            ball.backgroundColor = color
            let origin = 40 * index + 100
            ball.frame = CGRect(x:origin,y:origin,width:Int(ballSize.width),height:Int(ballSize.height))
            
            ball.layer.cornerRadius = ball.bounds.width / 2.0
            balls.append(ball)
            addSubview(ball)
            
        }
    }
    
    //первый клик
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first
        {
            let touchLocation = touch.location( in: self)
            
            print(String(describing: touchLocation))
            for ball in balls
            {
                if(ball.frame.contains(touchLocation))
                {
                    snapBehavior = UISnapBehavior(item:ball,snapTo:touchLocation)
                    snapBehavior?.damping = 0.5
                    animator?.addBehavior(snapBehavior!)
                }
            }
        }
    }
    
    public func addBall()
    {
//        //// add ball
//        let ball = UIView(frame: CGRect.zero)
//        
//        ball.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
//        
//        let origin = touchLocation.x
//        ball.frame = CGRect(x:Int((touchLocation.x)),y:Int((touchLocation.y)),width:Int(ballSize.width),height:Int(ballSize.height))
//        
//        
//        ball.layer.cornerRadius = ball.bounds.width / 2.0
//        
//        addSubview(ball)
        ////

    }
    //перемещение
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print("moved")
        if let touch = touches.first
        {
            
            
            let touchLocation = touch.location( in:self)
           // addBall(touchLocation.x,touchLocation.y)
            print(String(describing:touchLocation))
            if let snapBehavior = snapBehavior
            {
                print("change position to \(touchLocation) ")
                snapBehavior.snapPoint = touchLocation
            }
            
        }
    }
    //окончание
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let snapBehavior = snapBehavior
        {
            animator?.removeBehavior(snapBehavior)
        }
        snapBehavior = nil
    }
}
