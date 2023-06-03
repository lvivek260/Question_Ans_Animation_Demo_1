//
//  ViewController.swift
//  stack
//
//  Created by Mac on 20/05/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var viewPlatform: UIView!
    let ansBtn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
    let ansBtn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
    let ansBtn3 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonConfiguration()
        addButtonTarget()
    }
    
    func buttonConfiguration(){
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        let btnHeight: CGFloat = 30
        
        ansBtn1.frame = CGRect(x: 30, y: height-50-btnHeight, width: 80, height: btnHeight)
        ansBtn2.frame = CGRect(x: width-80-30, y: height-50-btnHeight, width: 80, height: btnHeight)
        ansBtn3.frame = CGRect(x: width/2 - 40, y: height-50-btnHeight-60, width: 80, height: btnHeight)
        
        ansBtn1.setTitle("Button1", for: .normal)
        ansBtn2.setTitle("Button2", for: .normal)
        ansBtn3.setTitle("Answar", for: .normal)
        
        ansBtn1.setTitleColor(.white, for: .normal)
        ansBtn2.setTitleColor(.white, for: .normal)
        ansBtn3.setTitleColor(.white, for: .normal)
        
        ansBtn1.backgroundColor = .tintColor
        ansBtn2.backgroundColor = .tintColor
        ansBtn3.backgroundColor = .tintColor
        
        ansBtn1.layer.cornerRadius = 15
        ansBtn2.layer.cornerRadius = 15
        ansBtn3.layer.cornerRadius = 15
        
        self.viewPlatform.addSubview(ansBtn1)
        self.viewPlatform.addSubview(ansBtn2)
        self.viewPlatform.addSubview(ansBtn3)
       
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .left
        questionLabel.text = "of the following is the ________ smallest  unit of  data computer "
        questionLabel.font = UIFont.systemFont(ofSize: 25)
    }
    
    func addButtonTarget(){
        ansBtn1.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        ansBtn2.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        ansBtn3.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    @objc func buttonClick(sender:UIButton){
        let btnHeight:CGFloat = 30
        
        let searchString = "________"
        let point = findStringOrigin(label: questionLabel, searchString: searchString)
        let mainViewX: CGFloat = point?.x ?? 0
        let mainViewY: CGFloat = point?.y ?? 0
        
        UIView.animate(withDuration: 1, animations: {
            sender.frame = CGRect(x: mainViewX , y: mainViewY , width: 80, height: btnHeight)
        })
    }
    
}

func findStringOrigin(label: UILabel, searchString: String) -> CGPoint? {
    guard let text = label.text else { return nil }
    
    let attributedText = NSMutableAttributedString(string: text)
    let font = label.font!
    
    // Set the font attribute for the attributed text
    attributedText.addAttribute(.font, value: font, range: NSRange(location: 0, length: attributedText.length))
    
    // Find the range of the search string within the label's text
    let range = (text as NSString).range(of: searchString)
    
    // Check if the search string is found in the text
    if range.location != NSNotFound {
        // Create a new label with the same properties to calculate the string's position
        let searchLabel = UILabel()
        searchLabel.numberOfLines = label.numberOfLines
        searchLabel.lineBreakMode = label.lineBreakMode
        searchLabel.textAlignment = label.textAlignment
        searchLabel.font = font
        searchLabel.text = text
        
        // Calculate the bounding rect for the search string within the new label
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: label.bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.lineBreakMode = label.lineBreakMode
        
        layoutManager.addTextContainer(textContainer)
        
        let glyphRange = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
        let boundingRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
        
        // Calculate the origin of the search string within the label
        let originX = label.frame.origin.x + boundingRect.origin.x
        let originY = label.frame.origin.y + boundingRect.origin.y
        
        return CGPoint(x: originX, y: originY)
    }
    
    return nil
}
