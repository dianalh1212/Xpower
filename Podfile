platform :ios, '9.0'
  use_frameworks!
target 'Xpower' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks


  # Pods for Xpower

  target 'XpowerTests' do
    inherit! :search_paths
    # Pods for testing
  end
    pod 'SwiftKeychainWrapper', '~> 3.0'
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'Firebase'
    pod 'Firebase/Auth'
    pod 'Firebase/Database'
    
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
    end
  end
end

