notifying_action :create do

  directory "#{node['shibboleth_idp']['install_dir']}" do
    mode "0755"
  end

  cookbook_file "#{node['shibboleth_idp']['installer_archive']}" do
    mode "0644"
  end

  script "unpack_archive" do
    interpreter "bash"
    cwd "#{node['shibboleth_idp']['install_dir']}"
    code "umask 0022 && unzip #{node['shibboleth_idp']['installer_archive']}"
    not_if "test -d #{node['shibboleth_idp']['installer_dir']}"
  end

  cookbook_file "#{node['shibboleth_idp']['installer_dir']}/src/main/webapp/login.jsp" do
    mode "0644"
  end
  
  cookbook_file "#{node['shibboleth_idp']['installer_dir']}/src/main/webapp/login.css" do
    mode "0644"
  end
    
  cookbook_file "#{node['shibboleth_idp']['installer_dir']}/src/main/webapp/images/logo.jpg" do
    mode "0644"
  end

  directory "#{node['shibboleth_idp']['installer_dir']}/src/main/webapp/WEB-INF/lib" do
    action :create
    mode "0755"
  end

  node["shibboleth_idp"]["extra_webapp_libraries"].each do |library|
    cookbook_file "#{node['shibboleth_idp']['installer_dir']}/src/main/webapp/WEB-INF/lib/#{library}" do
      mode "0644"
    end
  end

  node["shibboleth_idp"]["extra_libraries"].each do |library|
    cookbook_file "#{node['shibboleth_idp']['installer_dir']}/lib/#{library}" do
      mode "0644"
    end
  end

  node["shibboleth_idp"]["extra_docs"].each do |doc|
    cookbook_file "#{node['shibboleth_idp']['installer_dir']}/src/main/webapp/#{doc}" do
      mode "0644"
    end
  end

  template "#{node['shibboleth_idp']['installer_dir']}/src/main/webapp/WEB-INF/web.xml" do
    mode "0644"
  end

  directory "#{node['shibboleth_idp']["home"]}" do
    mode "0755"
  end

end
