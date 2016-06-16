
Pod::Spec.new do |s|

  s.name         = "SlateUtils"
  s.version      = "3.4.2.1"
  s.summary      = "utils of Slate FrameWork."


  s.description  = <<-DESC
       utils of Slate FrameWork.   
  
                   DESC

  s.homepage     = "https://github.com/islate/SlateUtils"
  s.license      = "MIT"
  s.author       = { "linyize" => "linyize@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/islate/SlateUtils.git", :branch => "master" }

  s.source_files = '*.{h,m}'

end
