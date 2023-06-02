#### Variables ####

export HOSTS_INI ?= hosts.ini

#### Start Ansible docker ####

ansible:
	export ANSIBLE_NAME=ansible-k8s; \
	sh ./scripts/ansible ssh-agent bash

### a. Private keys (for ssh and git)

list-keys:
	ssh-add -l

# add-keys:
# 	ssh-add <your key>

### b. Deugging

pingall:
	ansible-playbook -i $(HOSTS_INI) pingall.yml

### c. Provision k8s
k8s-install: rke2-install helm-install
k8s-uninstall: helm-uninstall rke2-uninstall

### d. Provision rke2
rke2-install:
	ansible-playbook -i $(HOSTS_INI) rke2.yml --tags install 
rke2-uninstall:
	ansible-playbook -i $(HOSTS_INI) rke2.yml --tags uninstall 

### e. Provision helm
helm-install:
	ansible-playbook -i $(HOSTS_INI) helm.yml --tags install 
helm-uninstall:
	ansible-playbook -i $(HOSTS_INI) helm.yml --tags uninstall