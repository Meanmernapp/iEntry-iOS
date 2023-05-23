//
//  NewHomeViewController.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 17/12/2022.
//

import UIKit
var globalNewHome : NewHomeViewController?
class NewHomeViewController: BaseController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variables
    
    var MenuList = [MenuData]()
    var isFirst = false
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUSerImageByIDApi()
        menuConfig()
        globalNewHome = self
        if isFirst {
            AppUtility.showSuccessMessage(message: "\("Access_Granted_First".localized) \(ShareData.shareInfo.obj?.name ?? "") \("Access_Granted_Last".localized)",showTitle: false)
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        tableView.layer.cornerRadius = 36
        tableView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        tableView.layer.masksToBounds = true
        if ShareData.shareInfo.RoleDataV2V2Obj == nil {
            self.roleData()
        }
    }
    
    func roleData() {
        self.showLoader()
        userhandler.getRoleTasks { result in
            self.hidLoader()
            if result?.success ?? false {
                ShareData.shareInfo.saveRoleDataV2(user: result)
                self.menuConfig()
                self.tableView.reloadData()
            }
            else {
                AppUtility.showErrorMessage(message: "Role Not Fetched")
            }

        } Failure: { error in
            AppUtility.showErrorMessage(message: "Role Not Fetched")
        }
    }
    
    func getUSerImageByIDApi(){
        if let base =  ShareData.shareInfo.obj?.selfie {
            if let image = self.convierteImagen(base64String: base) {
                Global.shared.selfiImage = image
            }
        }
        else {
            self.getUserInfo()
            Global.shared.selfiImage = UIImage(named: "user-png")!
        }
    }
    
    func getUserInfo(){
        userhandler.getUser(id: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            ShareData.shareInfo.saveUser(user: response?.data)
            self.getUSerImageByIDApi()
        }, Failure: {error in
        })
    }
    
    func menuConfig()  {
        MenuList.removeAll()
        if ShareData.shareInfo.userRole == .contractor {
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "HomeMenunotification")))
            MenuList.append(MenuData(Titl: "OPCIONES CÓDIGO QR".localized, Img: UIImage(named: "HomeMenuqr-scan")))
            MenuList.append(MenuData(Titl: "TOKEN DE ACCESO".localized, Img: UIImage(named: "HomeMenupin")))
            MenuList.append(MenuData(Titl: "MAPA DE LA COMPAÑIA".localized, Img: UIImage(named: "HomeMenuMap")))
            MenuList.append(MenuData(Titl: "CONTRATOS".localized, Img: UIImage(named: "ContractorIC")))
            MenuList.append(MenuData(Titl: "EMPLEADOS".localized, Img: UIImage(named: "HomeMenuemployees")))
            MenuList.append(MenuData(Titl: "VEHÍCULOS".localized, Img: UIImage(named: "HomeMenucar")))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "HomeMenuprofile")))
        }
        if ShareData.shareInfo.userRole == .contractoremplyee {
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "HomeMenunotification")))
            MenuList.append(MenuData(Titl: "OPCIONES CÓDIGO QR".localized, Img: UIImage(named: "HomeMenuqr-scan")))
            MenuList.append(MenuData(Titl: "MAPA DE LA COMPAÑIA".localized, Img: UIImage(named: "HomeMenuMap")))
            MenuList.append(MenuData(Titl: "CONTRATOS".localized, Img: UIImage(named: "ContractorIC")))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "HomeMenuprofile")))
        }
        
        else if ShareData.shareInfo.userRole == .provider {
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "HomeMenunotification")))
            MenuList.append(MenuData(Titl: "OPCIONES CÓDIGO QR".localized, Img: UIImage(named: "HomeMenuqr-scan")))
            MenuList.append(MenuData(Titl: "TOKEN DE ACCESO".localized, Img: UIImage(named: "HomeMenupin")))
            MenuList.append(MenuData(Titl: "MAPA DE LA COMPAÑIA".localized, Img: UIImage(named: "HomeMenuMap")))
            MenuList.append(MenuData(Titl: "ORDENES DE COMPRA".localized, Img: UIImage(named: "orderIC")))
            MenuList.append(MenuData(Titl: "EMPLEADOS".localized, Img: UIImage(named: "HomeMenuemployees")))
            MenuList.append(MenuData(Titl: "VEHÍCULOS".localized, Img: UIImage(named: "HomeMenucar")))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "HomeMenuprofile")))
            
        }
        else if ShareData.shareInfo.userRole == .provideremployee {
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "HomeMenunotification")))
            MenuList.append(MenuData(Titl: "OPCIONES CÓDIGO QR".localized, Img: UIImage(named: "HomeMenuqr-scan")))
            MenuList.append(MenuData(Titl: "MAPA DE LA COMPAÑIA".localized, Img: UIImage(named: "HomeMenuMap")))
            MenuList.append(MenuData(Titl: "ORDENES DE COMPRA".localized, Img: UIImage(named: "orderIC")))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "HomeMenuprofile")))
        }
        else if ShareData.shareInfo.userRole == .employees {
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 21 })) != nil {
                MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "HomeMenunotification")))
            }
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 3 })) != nil {
                MenuList.append(MenuData(Titl: "OPCIONES CÓDIGO QR".localized, Img: UIImage(named: "HomeMenuqr-scan")))
            }
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 4 })) != nil {
                MenuList.append(MenuData(Titl: "TOKEN DE ACCESO".localized, Img: UIImage(named: "HomeMenupin")))
            }
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 2 })) != nil {
                MenuList.append(MenuData(Titl: "MAPA DE LA COMPAÑIA".localized, Img: UIImage(named: "HomeMenuMap")))
            }
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 41 })) != nil {
                MenuList.append(MenuData(Titl: "INVITACIONES".localized, Img: UIImage(named: "HomeMenuemail")))
            }
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 31 })) != nil {
                
                MenuList.append(MenuData(Titl: "EVENTOS".localized, Img: UIImage(named: "HomeMenuevent")))
            }
            
            MenuList.append(MenuData(Titl: "VACACIONES".localized, Img: UIImage(named: "HomeMenuTravel")))
            
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 11 })) != nil {
                MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "HomeMenuprofile")))
            }
            
        }
    }
    
}

extension NewHomeViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(NewHomeMenuTableViewCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        cell.lbltile.text = MenuList[indexPath.row].Titl
        cell.img.image = MenuList[indexPath.row].Img
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indx = indexPath.row
        Global.shared.selectedIndex = indexPath.row + 1
        if ShareData.shareInfo.userRole == .contractor {
            
            
            switch indx {
            case 0:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyVerificationCodeVC") as? CompanyVerificationCodeVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 3:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 4 :
                let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"ContractVC") as? ContractVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 5:
                let vc = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            case 6:
                let vc = VehicalViewController(nibName: "VehicalViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            case 7:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
                self.navigationController?.pushViewController(vc!, animated: true)
            default:
                break
            }
            
            
            
        } else
        if ShareData.shareInfo.userRole == .contractoremplyee {
            
            
            switch indx {
            case 0:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 3:
                let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"ContractVC") as? ContractVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 4:
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
                let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyVerificationCodeVC") as? CompanyVerificationCodeVC
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
                let vc = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            case 6:
                let vc = VehicalViewController(nibName: "VehicalViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            case 7:
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
                let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 3:
                let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"OrdersVC") as? OrdersVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 4:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
                self.navigationController?.pushViewController(vc!, animated: true)
            default:
                break
            }
            
            
        }
        
        else if ShareData.shareInfo.userRole == .employees {
            
            let indx = MenuList[indexPath.row].Titl
            switch indx {
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


