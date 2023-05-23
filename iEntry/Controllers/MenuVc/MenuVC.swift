//
//  MenuVC.swift
//  iEntry
//
//  Created by ZAFAR on 10/08/2021.
//

import UIKit

struct MenuData {
    var Titl:String?
    var Img:UIImage?
    var id:Int?
}


class MenuVC: BaseController {
    //MARK:- struct use to make the list

    
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblname: UILabel!
    var MenuList = [MenuData]()
    var selectedIndex = Global.shared.selectedIndex
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarHidShow(isTrue: true)
        self.tblView.register(UINib.init(nibName: "menuCell", bundle: nil), forCellReuseIdentifier: "menuCell")
        self.lblname.text = ShareData.shareInfo.obj?.name
        self.lblemail.text = ShareData.shareInfo.obj?.email
        
        menuConfig()
        
        
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            let statusbarView = UIView()
            statusbarView.backgroundColor = #colorLiteral(red: 0.5144373178, green: 0.7346428037, blue: 0.7027089, alpha: 1)
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = #colorLiteral(red: 0.5144373178, green: 0.7346428037, blue: 0.7027089, alpha: 1)//UIColor.red
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: -  this funtion use  to append the array
    func menuConfig()  {
        
        if ShareData.shareInfo.userRole == .contractor {
            MenuList.append(MenuData(Titl: "HOME",Img: UIImage(named: "ic-home")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "OPCIONES CÓDIGO QR".localized, Img: UIImage(named: "ic-qr-code 1")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "TOKEN DE ACCESO".localized, Img: UIImage(named: "ic-key-solid")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "MAPA DE LA COMPAÑIA".localized, Img: UIImage(named: "ic-map-1")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "CONTRATOS".localized, Img: UIImage(named: "ic-contract")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "EMPLEADOS".localized, Img: UIImage(named: "users-solidSidemenu")))
            MenuList.append(MenuData(Titl: "VEHÍCULOS".localized, Img: UIImage(named: "ic-car")))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")?.withRenderingMode(.alwaysTemplate)))
        }
        if ShareData.shareInfo.userRole == .contractoremplyee {
            MenuList.append(MenuData(Titl: "HOME",Img: UIImage(named: "ic-home")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "OPCIONES CÓDIGO QR".localized, Img: UIImage(named: "ic-qr-code 1")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "MAPA DE LA COMPAÑIA".localized, Img: UIImage(named: "ic-map-1")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "CONTRATOS".localized, Img: UIImage(named: "ic-contract")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")?.withRenderingMode(.alwaysTemplate)))
            
        }
        
        else  if ShareData.shareInfo.userRole == .provider {
            MenuList.append(MenuData(Titl: "HOME",Img: UIImage(named: "ic-home")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "OPCIONES CÓDIGO QR".localized, Img: UIImage(named: "ic-qr-code 1")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "TOKEN DE ACCESO".localized, Img: UIImage(named: "ic-key-solid")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "MAPA DE LA COMPAÑIA".localized, Img: UIImage(named: "ic-map-1")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "ORDENES DE COMPRA".localized, Img: UIImage(named: "ic-contract-1")?.withRenderingMode(.alwaysTemplate)))

            MenuList.append(MenuData(Titl: "EMPLEADOS".localized, Img: UIImage(named: "users-solidSidemenu")))
            MenuList.append(MenuData(Titl: "VEHÍCULOS".localized, Img: UIImage(named: "ic-car")))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")?.withRenderingMode(.alwaysTemplate)))
        }
        else if ShareData.shareInfo.userRole == .provideremployee {
            MenuList.append(MenuData(Titl: "HOME",Img: UIImage(named: "ic-home")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "OPCIONES CÓDIGO QR".localized, Img: UIImage(named: "ic-qr-code 1")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "MAPA DE LA COMPAÑIA".localized, Img: UIImage(named: "ic-map-1")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "ORDENES DE COMPRA".localized, Img: UIImage(named: "ic-contract-1")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")?.withRenderingMode(.alwaysTemplate)))
            
        }
        else if ShareData.shareInfo.userRole == .employees {
            
            MenuList.append(MenuData(Titl: "HOME",Img: UIImage(named: "ic-home")?.withRenderingMode(.alwaysTemplate)))
                            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 21 })) != nil {
                MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")?.withRenderingMode(.alwaysTemplate)))
            }
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 3 })) != nil {
                MenuList.append(MenuData(Titl: "OPCIONES CÓDIGO QR".localized, Img: UIImage(named: "ic-qr-code 1")?.withRenderingMode(.alwaysTemplate)))
            }

            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 4 })) != nil {
                MenuList.append(MenuData(Titl: "TOKEN DE ACCESO".localized, Img: UIImage(named: "ic-key-solid")?.withRenderingMode(.alwaysTemplate)))
            }
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 2 })) != nil {
                MenuList.append(MenuData(Titl: "MAPA DE LA COMPAÑIA".localized, Img: UIImage(named: "ic-map-1")?.withRenderingMode(.alwaysTemplate)))
            }
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 41 })) != nil {
                MenuList.append(MenuData(Titl: "INVITACIONES".localized, Img: UIImage(named: "ic-invitation")?.withRenderingMode(.alwaysTemplate)))
            }
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 31 })) != nil {

                   MenuList.append(MenuData(Titl: "EVENTOS".localized, Img: UIImage(named: "ic-event")?.withRenderingMode(.alwaysTemplate)))
            }
            
            MenuList.append(MenuData(Titl: "VACACIONES".localized, Img: UIImage(named: "travell")?.withRenderingMode(.alwaysTemplate)))
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 11 })) != nil {
                MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")?.withRenderingMode(.alwaysTemplate)))
            }
             
        }
    }


}
//MARK: - here are the tableview datasource and delegate
extension MenuVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as? menuCell
        cell?.lbltile.text = MenuList[indexPath.row].Titl
        cell?.img.image = MenuList[indexPath.row].Img
        if selectedIndex == indexPath.row {
            cell?.bgView.backgroundColor = #colorLiteral(red: 0.3902164102, green: 0.6604216099, blue: 0.6162803769, alpha: 1)
            cell?.bgView.layer.cornerRadius = 5
        }
        
        else {
            cell?.bgView.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell?.bgView.layer.cornerRadius = 5
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indx = indexPath.row
//        if MenuList.count-1 != indexPath.row {
            Global.shared.selectedIndex = indexPath.row
//        }
        
        if ShareData.shareInfo.userRole == .contractor {
            switch indx {
            case 0:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 3:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyVerificationCodeVC") as? CompanyVerificationCodeVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 4:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 5:
                let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"ContractVC") as? ContractVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 6:
                let vc = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            case 7:
                let vc = VehicalViewController(nibName: "VehicalViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            case 8:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
                self.navigationController?.pushViewController(vc!, animated: true)
            default:
                break
            }
            
        }
        
        else if ShareData.shareInfo.userRole == .contractoremplyee {
            
            
            switch indx {
            case 0:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 3:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 4:
                let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"ContractVC") as? ContractVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 5:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
                self.navigationController?.pushViewController(vc!, animated: true)
            default:
                break
            }
            
            
            
        }
        else if ShareData.shareInfo.userRole == .provider {
            switch indx {
            case 0:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 3:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyVerificationCodeVC") as? CompanyVerificationCodeVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 4:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 5:
                let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"OrdersVC") as? OrdersVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 6:
                let vc = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            case 7:
                let vc = VehicalViewController(nibName: "VehicalViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            case 8:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
                self.navigationController?.pushViewController(vc!, animated: true)
            default:
                break
            }
            
        }
            else if ShareData.shareInfo.userRole == .provideremployee {
                switch indx {
                case 0:
                    let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
                    self.navigationController?.pushViewController(vc!, animated: true)
                case 1:
                    let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                    self.navigationController?.pushViewController(vc!, animated: true)
                case 2:
                    let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
                    self.navigationController?.pushViewController(vc!, animated: true)
                case 3:
                    let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
                    self.navigationController?.pushViewController(vc!, animated: true)
                case 4:
                    let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"OrdersVC") as? OrdersVC
                    self.navigationController?.pushViewController(vc!, animated: true)
                case 5:
                    let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
                    self.navigationController?.pushViewController(vc!, animated: true)
                default:
                    break
                }
            
            
        } else if ShareData.shareInfo.userRole == .employees {
            
            let indx = MenuList[indexPath.row].Titl
            switch indx {
            case "HOME".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            case "NOTIFICACIONES".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
            self.navigationController?.pushViewController(vc!, animated: true)
            case "OPCIONES CÓDIGO QR".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
            self.navigationController?.pushViewController(vc!, animated: true)
            case "TOKEN DE ACCESO".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyVerificationCodeVC") as? CompanyVerificationCodeVC
            self.navigationController?.pushViewController(vc!, animated: true)
            case "MAPA DE LA COMPAÑIA".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
            self.navigationController?.pushViewController(vc!, animated: true)
            case "EVENTOS".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"HomeVC") as? HomeVC
            self.navigationController?.pushViewController(vc!, animated: true)
            case "INVITACIONES".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"InvitationVC") as? InvitationVC
            self.navigationController?.pushViewController(vc!, animated: true)
            case "VACACIONES".localized:
            let vc = HolidaysViewController(nibName: "HolidaysViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            case "PERFIL".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
            self.navigationController?.pushViewController(vc!, animated: true)
        default:
            break
        }
            
        }
    }
    
}

