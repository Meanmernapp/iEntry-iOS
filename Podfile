# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iEntry' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iEntry

pod 'MaterialComponents/TextControls+FilledTextAreas'
pod 'MaterialComponents/TextControls+FilledTextFields'
pod 'MaterialComponents/TextControls+OutlinedTextAreas'
pod 'MaterialComponents/TextControls+OutlinedTextFields'

pod 'MaterialComponents/TextControls+FilledTextAreasTheming'
pod 'MaterialComponents/TextControls+FilledTextFieldsTheming'
pod 'MaterialComponents/TextControls+OutlinedTextAreasTheming'
pod 'MaterialComponents/TextControls+OutlinedTextFieldsTheming'

#pod 'MaterialComponents/TextFields'
#pod 'MaterialComponents/TextFields+Theming'
#
#pod 'MaterialComponents/TextFields'
#pod 'MaterialComponents/TextFields+ColorThemer'
#pod 'MaterialComponents/schemes/Color'

pod 'FittedSheets', '~> 2.5'
pod 'IQKeyboardManagerSwift'
pod 'AnimatableReload'
pod 'SideMenu'
pod 'DropDown'
pod 'SDWebImage'
pod 'AlamofireImage'
pod 'Alamofire'
pod 'Toast-Swift'
pod "AlignedCollectionViewFlowLayout"
pod 'Cosmos'
pod 'KRProgressHUD'
pod 'NVActivityIndicatorView'
pod 'NVActivityIndicatorView/Extended'
pod 'IBPCollectionViewCompositionalLayout'
pod 'DLRadioButton'
pod 'YPImagePicker'
pod 'DZNEmptyDataSet'
pod 'FittedSheets'
pod 'XLPagerTabStrip'
pod 'FSCalendar'
pod 'GoogleMaps'
pod 'GooglePlaces'
pod "SimpleAnimation"
pod 'HMSegmentedControl'
pod 'SMDatePicker'
pod 'Firebase/Crashlytics'
pod 'Firebase/Messaging'
pod 'Firebase/Analytics'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Messaging'
pod 'Firebase/Storage'
pod 'Firebase/Firestore'
pod 'PhoneNumberKit'
pod 'FlagPhoneNumber'
pod 'SwiftMessages'
pod 'ObjectMapper', '~> 3.4'
pod 'BLContactsViewController', '~> 0.1'
pod 'EPContactsPicker'
#pod 'PieCharts'
#pod 'JOCircularSlider'

post_install do |installer|
       installer.pods_project.targets.each do |target|
           target.build_configurations.each do |config|
               config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
           end
       end
   end


end
