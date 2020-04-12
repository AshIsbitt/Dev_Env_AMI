#
# Cookbook:: slave_node
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.



apt_update 'update_sources' do
  action :update
end

package 'python3-pip'


file '/home/ubuntu/requirements.txt' do
  mode '0777'
  action :create_if_missing
end

directory '/home/ubuntu/Downloads' do
  owner 'root'
  group 'root'
  mode '0777'
  action :create
end

template '/home/ubuntu/requirements.txt' do
  source 'requirements.txt.erb'
end

bash 'pip install requirements.txt' do
  code <<-EOL
  pip3 install -r /home/ubuntu/requirements.txt
  EOL
end

#James Jenins install
bash 'install_jenkins' do
  code <<-EOH
  echo "Adding apt-keys"
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list


echo "Updating apt-get"
sudo apt-get -qq update


echo "Installing default-java"
sudo apt-get -y install default-jre > /dev/null 2>&1
sudo apt-get -y install default-jdk > /dev/null 2>&1


echo "Installing git"
sudo apt-get -y install git > /dev/null 2>&1


echo "Installing git-ftp"
sudo apt-get -y install git-ftp > /dev/null 2>&1


echo "Installing jenkins"
sudo apt-get -y install jenkins > /dev/null 2>&1
  EOH
end
