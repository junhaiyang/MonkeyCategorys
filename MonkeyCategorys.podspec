 
Pod::Spec.new do |s|
 

  s.name         = "MonkeyCategorys"
  s.version      = "1.0"
  s.summary      = "MonkeyCategorys Sample Task....."
 

  s.homepage     = "https://github.com/junhaiyang/MonkeyCategorys"
 
  s.license      = "MIT"
 
  s.author             = { "yangjunhai" => "junhaiyang@gmail.com" } 
  s.ios.deployment_target = "7.0" 

  s.ios.framework = 'UIKit'
 
  s.source = { :git => 'https://github.com/junhaiyang/MonkeyCategorys.git' , :tag => '1.0'} 
 
  s.requires_arc = true

  s.source_files = '*.{h,m,mm}'  

  s.subspec 'DYScreenRatioAutoLayout' do |ds|
    
    ds.source_files = 'DYScreenRatioAutoLayout/*.{h,m,mm}' 
          
  end

  s.subspec 'NSDate' do |ds|
    
    ds.source_files = 'NSDate/*.{h,m,mm}' 
          
  end


  s.subspec 'NSObject' do |ds|
    
    ds.source_files = 'NSObject/*.{h,m,mm}' 
          
  end

  s.subspec 'NSString' do |ds|
    
    ds.source_files = 'NSString/*.{h,m,mm}' 
          
  end

  s.subspec 'UIColor' do |ds|
    
    ds.source_files = 'UIColor/*.{h,m,mm}' 
          
  end
  s.subspec 'UIImage' do |ds|
    
    ds.source_files = 'UIImage/*.{h,m,mm}' 
          
  end

  s.subspec 'UIResponder+Interceptor' do |ds|
    
    ds.source_files = 'UIResponder+Interceptor/*.{h,m,mm}' 

    ds.subspec 'ExtInterceptor' do |ks|
    
      ks.source_files = 'UIResponder+Interceptor/ExtInterceptor/*.{h,m,mm}' 
          
    end
          
  end
  
  s.dependency 'Reachability' , '3.2'
   
 
end
