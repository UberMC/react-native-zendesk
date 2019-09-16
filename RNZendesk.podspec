require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |spec|
  spec.name         = "RNZendesk"
  spec.summary      = "Zendesk framework for ReactNative"
  spec.version      = package['version']

  spec.authors      = package['author']
  spec.homepage     = "https://github.com/Caribu/react-native-zendesk"
  spec.license      = package['license']
  spec.platform     = :ios, "9.3"

  spec.source       = { :git => "https://github.com/Caribu/react-native-zendesk.git" }
  spec.source_files = "ios/**/*.{h,m,swift}"


  spec.pod_target_xcconfig = { 'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/Headers/Public/React"' }
  spec.dependency "ZendeskSDK"

end