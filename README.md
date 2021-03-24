Wasstraat Ansible playbooks to execute shell scripts
==========================

Files structure
---------------

    - files - directory contains all installation files
        - flexera - default location for Flexera
        - mcafee - default location for McAfee
        - nagios - default location for Nagios
        - scom - default location for SCOM
        - tssa - default location for TSSA
    - group_vars
        - all.yml - default values for all hosts
    - roles - directory contains all roles used in the playbook
    - tasks - common tasks, which are included in roles
    - ansible-playbook-wrapper.sh - bash script to trigger run of playbook including custom log file
    - install-agent.yml - main ansible playbook
    - inv_sandbox - example of inventory

Common configuration
--------------------

Default configuration for playbook execution can be found in **group_vars/all.yml** file.

Section "Default global variables" defines parameters for playbook:
- **installation_files** - location of installation files per agent
- **remote_agents_dir** - location on remote host, where installation files are copied to

Section "Agent installation configuration" contains parameters used for specific agent installation

Section "Health check configuration" contains parameters used for health checks

All default parameters can be overwritten using "-e" or "--extra-vars" in command line

Usage
------

To run agent installation use script ansible-playbook-wrapper.sh instead of using ansible-playbook directly.
The wrapper contains functionality to dynamically set log file per playbook execution.
Logs are stored in directory: logs/

You can use tags to define tool to be installed

Example:

Run Mcafee installation:

`./ansible-playbook-wrapper.sh install-agent.yml -i inv_sandbox --tags="mcafee"`

Run McAfee installation, reboot hosts, check agent installation after reboot:

`./ansible-playbook-wrapper.sh install-agent.yml -i inv_sandbox --tags="mcafee,reboot,healthcheck"`
