require 'json'
require 'cgi'


module JsClientBridge
end

dir = File.join(Pathname(__FILE__).dirname.expand_path, 'js-client-bridge', 'responses/')
%w(ok error exception validation).each {|f| require dir + f }

dir = File.join(Pathname(__FILE__).dirname.expand_path + 'js-client-bridge/')
require dir + 'responses'