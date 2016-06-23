Pod::Spec.new do |s|
  s.name         = 'LFCategory'
  s.summary      = 'A collection of LaiFeng’s Category.'
  s.version      = '1.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'wangzhiwei' => 'wangzhiwei01@youku.com' }
  s.social_media_url = 'https://github.com/LaiFengiOS'
  s.homepage     = 'https://github.com/LaiFengiOS'
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.source       = { :git => 'https://github.com/LaiFengiOS/LFCategory.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'LFCategory/**/*.{h,m}'
  s.public_header_files = 'LFCategory/**/*.{h}'
s.framework = "CoreGraphics"


  s.libraries = 'z'
s.dependency 'MBProgressHUD','~>0.9.1'
end
