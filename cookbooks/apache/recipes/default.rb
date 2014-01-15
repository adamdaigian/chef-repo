#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "apache2" do
	action :install
end

execute "a2dissite default" do
	only_if do
		File.symlink?("/etc/apache2/sites-enabled/000-default")
	end
	notifies :restart, "service[apache2]"
end

node['apache']['sites'].each do |site_name, site_data| 
	document_root = "/srv/apache/#{site_name}"

	template "/etc/apache2/sites-available/#{site_name}" do
		source "index.html.erb"
		variables(
			:site_name => site_name,
			:port => site_data['port']
		)
		notifies :restart, "service[apache2]"
	end

	execute "a2ensite #{site_name}" do
		not_if do
			File.symlink?("/etc/apache2/sites-enabled/#{site_name}")
		end
		notifies :restart, "service[apache2]"
	end

	directory document_root do
		mode "0755"
		recursive true
	end

	template "#{document_root}/index.html" do
		source "index.html.erb"
		variables (
			:site_name => site_name,
			:port => site_data['port']
		)
		mode "0644"
	end
end

service "apache2" do
  action [:enable, :start]
end