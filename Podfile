source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

target 'TrafficDemo' do
  use_frameworks!
  
  pod 'RxSwift'
  pod 'Moya/RxSwift'
  pod 'Moya-ObjectMapper/RxSwift'
  pod 'Moya-ModelMapper/RxSwift'
  pod 'ObjectMapper'
  pod 'RxCocoa'
  pod 'RxOptional', '~> 2'
  target 'TrafficDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end
