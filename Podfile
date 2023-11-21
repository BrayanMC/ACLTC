# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def networkingpods
  pod 'Alamofire', '~> 5.4.4'
end

def uipods
  pod 'SkeletonView'
end

def dataPods
  pod 'KeychainAccess'
end

def allpods
  pod 'GoogleMaps'
end

target 'ACLTC' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  networkingpods
  uipods
  dataPods
  allpods
  
  # Pods for ACLTC

  target 'ACLTCTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ACLTCUITests' do
    # Pods for testing
  end

end
