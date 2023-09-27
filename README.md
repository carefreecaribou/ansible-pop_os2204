# Pop_OS! 22.04LTS Initialization Playbook
This is my personal playbook for Pop_OS! 22.04 LTS. It is designed to be ran locally on the machine being provisioned. 

# Initialization Steps
On a newly installed image:
- Connect to a wireless network.
- To overwrite the defaults, save a confiration file as ~/provision-config.yml. To download the current default config for overriding it:

```bash
curl -fsSL https://raw.githubusercontent.com/carefreecaribou/ansible-pop_os2204/main/default.config.yml -o provision-config.yml
```
- If you autoprovision, the `remove_autostart` variable is appended to your config file to prevent running the autoprovision specific tasks.
- Open a terminal, curl the `.autoprovision.sh` script and pipe to bash to autoprovision the system:
```bash
curl -fsSL https://raw.githubusercontent.com/carefreecaribou/ansible-pop_os2204/main/.autoprovision.sh | bash
```

# Integrate with Vagrant
Did you know that you can integrate an ansible playbook straight into a Vagrantfile? You can provision vagrant machines with files or scripts. To provision a vagrant file with the playbook already downloaded, insert the following into your playboocurl -fsSL https://raw.githubusercontent.com/carefreecaribou/ansible-pop_os2204/main/default.config.yml -o override.ymlk:
```Ruby
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "/dir/to/playbook/main.yml"
  end
```

## Example Vagrantfile
```Ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "custom/popos2204"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "/home/user/playbook/main.yml"
    # ansible.verbose = "vv"
  end
end
```