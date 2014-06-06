#
# Cookbook Name:: xhprof
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "php"
case node[:platform]
when "debian","ubuntu"
  execute "apt-get update" do
    action :nothing
  end

  directory "#{node['php']['ext_conf_dir']}" do
    owner 'root'
    group 'root'
    recursive true
  end

  %w{python-software-properties pkg-config}.each do |pkg|
    package pkg
  end

  php_pear "xhprof" do
    preferred_state "beta"
    action :install
  end

  package "php5-xhprof"

when "mac_os_x"
  package "xhprof"

  template "/usr/local/etc/php5/conf.d/xhprof.ini" do
    source "xhprof.ini.erb"
  end
end
