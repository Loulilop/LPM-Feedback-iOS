Pod::Spec.new do |s|
    s.name             = 'LPM-Feedback'
    s.version          = '0.1.0'
    s.summary          = 'LPM-Feedback.'

    s.homepage         = 'https://github.com/loup-studio/LPM-Feedback-iOS'
    s.license          = { :type => 'Proprietary', :file => 'LICENSE' }
    s.author           = { 'Lukasz' => 'lukasz@intheloup.io' }
    s.source           = { :git => 'https://github.com/loup-studio/LPM-Feedback-iOS.git', :tag => s.version.to_s }

    s.ios.deployment_target = '9.0'
    s.source_files = 'Feedback/Classes/**/*'
    s.resource_bundle = { 'LPM-Feedback' => ['Feedback/Assets/**/*'] }
#s.resources = 'Feedback/**/*.{png,json}'


    s.dependency 'SwiftCommons'
    s.dependency 'IQKeyboardManagerSwift', '~> 4.0'

    s.description      = <<-DESC
LMP Feedback lib
                         DESC

end
