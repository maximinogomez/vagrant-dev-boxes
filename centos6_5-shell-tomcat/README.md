#### Linking a "host" vagrant directory to Tomcat's webapps on guest machine.
- From inside centos6_5-shell-tomcat => mkdir {directory name}. 
Note that I'm creating two directories below for organizing my apps better.
  - $ mkdir -p tmp/myapp 
  
- SSH to the guest machine.
  - $ vagrant ssh
  - $ cd /usr/local/tomcat/webapps/
- Create a symbolic soft link => ln -s {/path/to/file-name} {link-name}
  - $ sudo ln -s /vagrant/tmp/myapp myapp

- Open browser on the host machine and enter localhost:8080/myapp in the url bar.
