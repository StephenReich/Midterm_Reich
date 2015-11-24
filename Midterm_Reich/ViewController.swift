//
//  ViewController.swift
//  Midterm_Reich
//
//  Created by Stephen Reich on 10/5/15.
//  Copyright © 2015 Stephen Reich. All rights reserved.
//

import UIKit
import Foundation

var eventLabel1:String = ""
var summaryLabel1:String = ""
var effectiveLabel1:String = ""
var expiresLabel1:String = ""
var urgencyLabel1:String = ""
var severityLabel1:String = ""
var certaintyLabel1:String = ""
var linkLabel1:String = ""

var coordinates:[Double] = []
var polygon:[String] = []

class ViewController: UIViewController, NSXMLParserDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource
{

    var states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    
    var eventFound:Bool = false
    var summaryFound:Bool = false
    var effectiveFound:Bool = false
    var expiresFound:Bool = false
    var urgencyFound:Bool = false
    var severityFound:Bool = false
    var certaintyFound:Bool = false
    var linkFound:Bool = false
    var polygonFound:Bool = false
    
    var event:[String] = []
    var summary:[String] = []
    var effective:[String] = []
    var expires:[String] = []
    var urgency:[String] = []
    var severity:[String] = []
    var certainty:[String] = []
    var link:[String] = []
    
    var effectiveDate = NSDate()
    var expiresDate = NSDate()
    var dateFormatter = NSDateFormatter()
    
    var effectiveDateString:String = ""
    var expiresDateString:String = ""
    
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var alertTable: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
    //PICKER VIEW FUNCTIONS
    func numberOfComponentsInPickerView(pickerView:UIPickerView) -> Int
    {
        return 1
    }
    
   
    
    func pickerView(pickerView:UIPickerView, numberOfRowsInComponent component:Int) ->Int
    {
        return states.count
    }
    
    func pickerView(pickerView:UIPickerView, titleForRow row:Int, forComponent component:Int) -> String?
    {
        return states[row]
    }
    
    func clearData()
    {
        event.removeAll()
        summary.removeAll()
        effective.removeAll()
        expires.removeAll()
        urgency.removeAll()
        severity.removeAll()
        certainty.removeAll()
        link.removeAll()
        polygon.removeAll()
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        clearData()
        
        var url = "http://alerts.weather.gov/cap/ZZ.php?x=0"
        
        switch states[statePicker.selectedRowInComponent(0)]{
        case "Alabama":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "al")
        case "Alaska":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ak")
        case "Arizona":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "az")
        case "Arkansas":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ar")
        case "California":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ca")
        case "Colorado":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "co")
        case "Connecticut":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ct")
        case "Delaware":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "de")
        case "Florida":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "fl")
        case "Georgia":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ga")
        case "Hawaii":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "hi")
        case "Idaho":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "id")
        case "Illinois":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "il")
        case "Indiana":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "in")
        case "Iowa":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ia")
        case "Kansas":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ks")
        case "Kentucky":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ky")
        case "Louisiana":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "la")
        case "Maine":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "me")
        case "Maryland":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "md")
        case "Massachusetts":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ma")
        case "Michigan":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "mi")
        case "Minnesota":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "mn")
        case "Mississippi":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ms")
        case "Missouri":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "mo")
        case "Montana":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "mt")
        case "Nebraska":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ne")
        case "Nevada":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "nv")
        case "New Hampshire":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "nh")
        case "New Jersey":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "nj")
        case "New Mexico":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "nm")
        case "New York":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ny")
        case "North Carolina":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "nc")
        case "North Dakota":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "nd")
        case "Ohio":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "oh")
        case "Oklahoma":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ok")
        case "Oregon":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "or")
        case "Pennsylvania":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "pa")
        case "Rhode Island":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ri")
        case "South Carolina":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "sc")
        case "South Dakota":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "sd")
        case "Tennessee":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "tn")
        case "Texas":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "tx")
        case "Utah":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "ut")
        case "Vermont":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "vt")
        case "Virginia":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "va")
        case "Washington":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "wa")
        case "West Virginia":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "wv")
        case "Wisconsin":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "wi")
        case "Wyoming":
            url = url.stringByReplacingOccurrencesOfString("ZZ", withString: "wy")
        default:
            url = "http://alerts.weather.gov/cap/al.php?x=0"
        }
        let newUrl = NSURL(string: url)
        let xmlParser = NSXMLParser(contentsOfURL: newUrl!)
        xmlParser?.delegate = self
        xmlParser?.parse()
        
        self.alertTable.reloadData()
    }
    
    
    //PARSER FUNCTIONS
    func parser(parser:NSXMLParser, didStartElement elementName:String, namespaceURI:String?, qualifiedName qName: String?, attributes attributeDict:[String:String])
    {
        if(elementName == "cap:event")
        {
            eventFound = true
        }
        if(elementName == "summary")
        {
            summaryFound = true
        }
        if(elementName == "cap:effective")
        {
            effectiveFound = true
        }
        if(elementName == "cap:expires")
        {
            expiresFound = true
        }
        if(elementName == "cap:urgency")
        {
            urgencyFound = true
        }
        if(elementName == "cap:severity")
        {
            severityFound = true
        }
        if(elementName == "cap:certainty")
        {
            certaintyFound = true
        }
        if(elementName == "link")
        {
            link.append(attributeDict["href"]!)
        }
        if(elementName == "cap:polygon"){
            polygonFound = true
        }
    }

    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if(elementName == "cap:event")
        {
            eventFound = false
        }
        if(elementName == "summary")
        {
            summaryFound = false
        }
        if(elementName == "cap:effective")
        {
            effectiveFound = false
        }
        if(elementName == "cap:expires")
        {
            expiresFound = false
        }
        if(elementName == "cap:urgency")
        {
            urgencyFound = false
        }
        if(elementName == "cap:severity")
        {
            severityFound = false
        }
        if(elementName == "cap:certainty")
        {
            certaintyFound = false
        }
        if(elementName == "cap:polygon"){
            polygonFound = false
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if(eventFound)
        {
            event.append(string)
        }
        if(summaryFound)
        {
            summary.append(string)
        }
        if(effectiveFound)
        {
            effective.append(string)
        }
        if(expiresFound)
        {
            expires.append(string)
        }
        if(urgencyFound)
        {
            urgency.append(string)
        }
        if(severityFound)
        {
            severity.append(string)
        }
        if(certaintyFound)
        {
            certainty.append(string)
        }
        if(polygonFound)
        {
            polygon.append(string)
        }
    }
    
    
    //TABLE VIEW FUNCTIONS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.event.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"cell")
        let finalExpires = expires[indexPath.row].stringByReplacingOccurrencesOfString("T", withString: "  ")
        cell.textLabel?.text = event[indexPath.row]
        cell.detailTextLabel?.text = finalExpires
        
        let item = severity[indexPath.row]
            switch item{
            case "Moderate":
                cell.contentView.backgroundColor = UIColor.yellowColor()
            case "Severe":
                cell.contentView.backgroundColor = UIColor.orangeColor()
            case "Extreme":
                cell.contentView.backgroundColor = UIColor.redColor()
            default:
                cell.contentView.backgroundColor = UIColor.clearColor()
            }
        return cell
    }
    
    func tableView(tvMain: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("Details", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "Details"
        {
            let secondVC : SecondViewController = segue.destinationViewController as! SecondViewController
            let indexPath = self.alertTable.indexPathForSelectedRow!
            
            if polygon.count > 0
            {
                let coordinatesString:String = polygon[indexPath.row]
                let coordinatesArray = coordinatesString.componentsSeparatedByString(" ")
                let center = coordinatesArray[0]
                let centerArray = center.componentsSeparatedByString(",")
                let centerLat = Double(centerArray[0])
                let centerLon = Double(centerArray[1])
                coordinates.append(centerLat!)
                coordinates.append(centerLon!)
                
                /**
                let point1 = Double(coordinatesArray[1])
                let point2 = Double(coordinatesArray[2])
                let point3 = Double(coordinatesArray[3])
                let point4 = Double(coordinatesArray[4])
                let point5 = Double(coordinatesArray[5])
                
                coordinates.append(point1!)
                coordinates.append(point2!)
                coordinates.append(point3!)
                coordinates.append(point4!)
                coordinates.append(point5!)
                */
                
            }
            
            print("\(event[indexPath.row])")
            print("\(summary[indexPath.row])")
            print("\(effective[indexPath.row])")
            print("\(expires[indexPath.row])")
            print("\(urgency[indexPath.row])")
            print("\(severity[indexPath.row])")
            print("\(certainty[indexPath.row])")
        
            let finalEffective = effective[indexPath.row].stringByReplacingOccurrencesOfString("T", withString: "  ")
            let finalExpires = expires[indexPath.row].stringByReplacingOccurrencesOfString("T", withString: "  ")
            
            eventLabel1 = "\(event[indexPath.row])"
            summaryLabel1 = "\(summary[indexPath.row])"
            effectiveLabel1 = "\(finalEffective)"
            expiresLabel1 = "\(finalExpires)"
            urgencyLabel1 = "\(urgency[indexPath.row])"
            severityLabel1 = "\(severity[indexPath.row])"
            certaintyLabel1 = "\(certainty[indexPath.row])"
            linkLabel1 = "\(link[indexPath.row])"
            
            print("\(linkLabel1)")

            secondVC.eventLabel?.text = eventLabel1
            secondVC.summaryText?.text = summaryLabel1
            secondVC.effectiveLabel?.text = effectiveLabel1
            secondVC.expiresLabel?.text = expiresLabel1
            secondVC.urgencyLabel?.text = urgencyLabel1
            secondVC.severityLabel?.text = severityLabel1
            secondVC.certaintyLabel?.text = certaintyLabel1
        }
    }
}