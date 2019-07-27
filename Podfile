# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

use_frameworks!

def shared_pods

    # Social Logins
    pod 'FacebookCore'
    pod 'FacebookLogin'
    pod 'FacebookShare'
    
    pod 'Google'
    pod 'GoogleSignIn'
    pod 'GoogleMaps'
    
    pod 'Alamofire'
end

target 'NodeLearningApp' do
    shared_pods
end
  
post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['ENABLE_BITCODE'] = 'NO'
          config.build_settings.delete('CODE_SIGNING_ALLOWED')
          config.build_settings.delete('CODE_SIGNING_REQUIRED')
      end
  end
end
