# Inspired by blog post by Andy Miller
# https://getgrav.org/blog/macos-sierra-apache-multiple-php-versions

# Below command is not required, if XCode is already installed
xcode-select --install # Needs an interaction on GUI

# Needs password input!
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null
brew install httpd

sudo brew services start httpd

# You need to set httpd.conf
# 1. Change port number to 80
#	Listen 8080 -> Listen 80
# 2. Change DocumentRoot
#	 When adding, it is not recommended to have double quotation mark.
# 	"/usr/local/var/www" -> /Users/YourWorkspace
# 	and change directory in <Document > tag & change to "AllOveride All"
# 3. Enable rewrite_module (Uncomment it)
# 4. Change User & Group
# 		User your_user
# 		Group staff
# 5. Change servername to localhost
#		ServerName locahost

brew install php56 --with-httpd
brew unlink php56
brew install php70 --with-httpd
brew unlink php70
brew install php71 --with-httpd
brew unlink php71
brew install php72 --with-httpd
brew unlink php72

# Change the path to php_module for each version like below in httpd.conf
# 	LoadModule php5_module    /usr/local/opt/php56/libexec/apache2/libphp5.so

if test !$(which sphp); then
	curl -L https://gist.github.com/w00fz/142b6b19750ea6979137b963df959d11/raw > /usr/local/bin/sphp
	chmod +x /usr/local/bin/sphp
fi


