2/27/20
# Create a local apache webb server and php website that allows for searching and viewing of local files on a mac
# tutorial: https://osxdaily.com/2015/08/30/automatically-start-apache-mac-os-x-boot/

# Initiate Web server
# turn on apache web server
sudo apachectl start

# turn on php
# uncomment php library using favorite text editor (mine is vim)
sudo vim /etc/apache2/httpd.conf
# search for php
# uncomment LoadModule php3_module libexec/apache2/libphp7.so by deleting "#"
# save and exit

# create folder to hold site
# I want to make a website that allows for searching and viewing of local files
# Add unzipped files from directorylister to folder
# get from github: https://github.com/DirectoryLister/DirectoryLister
# configure .env.example and rename .env

# set directory for server to load in favorite text editor
sudo vim /etc/apache2/httpd.conf
# Search for Library
# Replace both occurrences of /Library/WebServer/Documents with location of your website folder
# save and exit

# restart server
sudo apachectl restart

# kill server
sudo apachectl stop

# Set apache web server to start on mac book
sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist


