//
//  EPContactCell.swift
//  EPContacts
//
//  Created by Prabaharan Elangovan on 13/10/15.
//  Copyright © 2015 Prabaharan Elangovan. All rights reserved.
//

import UIKit

class EPContactCell: UITableViewCell {
    
    @IBOutlet weak var contactTextLabel: UILabel!
    @IBOutlet weak var contactDetailTextLabel: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactInitialLabel: UILabel!
    @IBOutlet weak var contactContainerView: UIView!
    @IBOutlet weak var checkButton: UIButton!
    
    var contact: EPContact?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
        contactContainerView.layer.masksToBounds = true
        contactContainerView.layer.cornerRadius = contactContainerView.frame.size.width/2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateInitialsColorForIndexPath(_ indexpath: IndexPath) {
        //Applies color to Initial Label
        let colorArray = [EPGlobalConstants.Colors.amethystColor,EPGlobalConstants.Colors.asbestosColor,EPGlobalConstants.Colors.emeraldColor,EPGlobalConstants.Colors.peterRiverColor,EPGlobalConstants.Colors.pomegranateColor,EPGlobalConstants.Colors.pumpkinColor,EPGlobalConstants.Colors.sunflowerColor]
        let randomValue = (indexpath.row + indexpath.section) % colorArray.count
        contactInitialLabel.backgroundColor = colorArray[randomValue]
    }
    
    @IBAction func checkAction(_ sender: UIButton) {

    }
    func updateContactsinUI(_ contact: EPContact, indexPath: IndexPath, subtitleType: SubtitleCellValue) {
        self.contact = contact
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 14.0)!]
        let simpleAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                 NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 14.0)!]
        let myString = NSMutableAttributedString(string:"Nombre: ", attributes: simpleAttributes )
        let myName = NSMutableAttributedString(string: contact.displayName(), attributes: myAttribute )
        myString.append(myName)
        self.contactTextLabel?.attributedText = myString
        //Update all UI in the cell here
        updateSubtitleBasedonType(subtitleType, contact: contact)
        if contact.thumbnailProfileImage != nil {
            self.contactImageView?.image = contact.thumbnailProfileImage
            self.contactImageView.isHidden = false
            self.contactInitialLabel.isHidden = true
        } else {
            self.contactInitialLabel.text = contact.contactInitials()
            updateInitialsColorForIndexPath(indexPath)
            self.contactImageView.isHidden = true
            self.contactInitialLabel.isHidden = false
        }
    }
    
    func updateSubtitleBasedonType(_ subtitleType: SubtitleCellValue , contact: EPContact) {
        
        switch subtitleType {
            
        case SubtitleCellValue.phoneNumber:
            let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 14.0)!]
            let simpleAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                     NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 14.0)!]
            let myString = NSMutableAttributedString(string:"Celular: ", attributes: simpleAttributes )
            let myNumber = NSMutableAttributedString(string: contact.phoneNumbers.first?.phoneNumber ?? "0", attributes: myAttribute )
            myString.append(myNumber)
            self.contactDetailTextLabel.attributedText = myString
            
        default :
            self.contactDetailTextLabel.text = "No Number Found"
        }
    }
}
