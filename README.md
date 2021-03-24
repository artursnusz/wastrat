Wasstraat Ansible playbooks to execute shell scripts
==========================

Files structure
---------------
     - group_vars
        - all.yml - default values for all hosts
     - host_vars
        - svead-ftp-n003.yml - default values for the svead-ftp-n003 host
        - svead-ftp-p003.yml - default values for the svead-ftp-p003 host
        - svead-ftp-p001.yml - default values for the svead-ftp-p001 host

    - roles - directory contains all roles used in the playbook

    - tasks - common tasks, which are included in roles

    - ansible-playbook-wrapper.sh - bash script to trigger run of playbook including custom log file

    - ftp-disk-usage.yml - ansible playbook for the ftp disk usage script's execution
    - ftp-file-system-usage.yml - ansible playbook for the ftp file system usage script's execution
    - ftp-make-dir.yml - ansible playbook for the ftp make dir scrip's execution
    - ftp-reset-dir-permissions.yml - ansible playbook for the ftp reset dir permissions script's execution
    - ftp-view-log.yml - ansible playbook for the ftp view log script's execution
    - inventory_hosts - example of inventory

Common configuration
--------------------

Default configuration for playbook execution can be found in **group_vars/all.yml** file.

All default parameters can be overwritten using "-e" or "--extra-vars" in command line

Usage
------

To run agent installation use script ansible-playbook-wrapper.sh instead of using ansible-playbook directly.
The wrapper contains functionality to dynamically set log file per playbook execution.
Logs are stored in directory: logs/

You can use tags to define tool to be installed

Example:

Run FTP disk usage script:

`./ansible-playbook-wrapper.sh ftp-disk-usage.yml -i inventory_hosts"`
