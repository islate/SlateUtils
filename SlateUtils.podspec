
Pod::Spec.new do |s|

  s.name         = "SlateUtils"
  s.version      = "3.4.2.1"
  s.summary      = "utils of Slate FrameWork."


  s.description  = <<-DESC
       utils of Slate FrameWork.   json urlencode md5 base64 aes des 
  
                   DESC

  s.homepage     = "https://github.com/islate/SlateUtils"
  s.license      = "Apache 2.0"
  s.author       = { "linyize" => "linyize@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/islate/SlateUtils.git", :tag => s.version.to_s }

  s.source_files = '*.{h,m}'

end
