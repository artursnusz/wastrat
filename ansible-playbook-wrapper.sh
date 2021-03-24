#!/bin/bash

# path for log file
logPath="logs" 

usage() {
    echo "
Usage: $0 <playbook_filename> [ansible-playbook options]

The wrapper triggers run of ansible playbook with custom log file.
The new log file is created for each playbook run.
All provided options are passed to ansible-playbook binary, use ansible-playbok -h to get list of available options

Example: $0 install.yml -i inventory_file --tags=test -v"
}

main() {
    while getopts ":h" opt; do
        case ${opt} in
            h ) 
                usage
                exit 1
                ;;
        esac
    done

    # create log directory if not exists
    if [[ ! -e $logPath ]]
    then
        echo "WARNING: Log path \"$logPath\" doesn't exists - creating directory"
        mkdir -p $logPath
    fi

    # check if first parameter is playbook file
    if [[ ! -z "$1" && "$1" =~ ^.*.(yml|yaml)$ ]]
    then
        datetime=$(date +%Y_%m_%d_%H_%M)
        # regexp to find tags from command
        regex="(\ --tags|\ -t)\=?[\ ]*([0-9A-Za-z\,\"\'\-]+)"
        tags=""
        # if found then replace unallowed characters
        if [[ "$@" =~ $regex ]]; then
            if [[ -n ${BASH_REMATCH[2]} || -z ${BASH_REMATCH[2]-isset} ]]; then
                tags=${BASH_REMATCH[2]//\"/""}
                tags=${tags//\'/""}
                tags=${tags//\,/"_"}
                tags="${tags}_"
            fi
        fi
        # construct log filename
        filename="$1_$tags$datetime.log"

        echo "--- RUNNING ANSIBLE PLAYBOOK ---"
        echo "Playbook: $1"
        echo "Log path: $logPath/$filename"

        ANSIBLE_LOG_PATH="$logPath/$filename" ANSIBLE_HOST_KEY_CHECKING=False ANSIBLE_SHOW_CUSTOM_STATS=True ansible-playbook $@
        
        echo ""
        echo "You can find all log in: $logPath/$filename"
        echo ""
    else
        echo "ERROR: First parameter must be the playbook filename"
        exit 1
    fi

    exit 0
}

main $@
