#!/bin/bash

# Check if the arguments are provided
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILE=$1
PWD=$2

# Check if the file exists
if [[ ! -f $FILE ]]; then
    echo "Error: File $FILE not found."
    exit 1
fi

# Process each line of the file
while IFS= read -r line; do
    # Extract username and authorized key
    username=$(echo "$line" | awk '{print $1}')
    key=$(echo "$line" | awk '{$1=""; print $0}' | sed 's/^ *//') # remove leading spaces

    # Check if user exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists."
    else
        # Create user with default options
        useradd -m -s /bin/bash "$username"
        echo "User $username created."
    fi

    # Add user to users group
    usermod -aG users,sudo,docker $username
    echo "$username added to users, sudo and docker group."

    # Create .ssh directory for the user if it doesn't exist
    user_ssh_dir="/home/$username/.ssh"
    mkdir -p "$user_ssh_dir"
    chown "$username:$username" "$user_ssh_dir"
    chmod 700 "$user_ssh_dir"

    # Add the authorized key only if it doesn't exist
    authorized_keys_file="$user_ssh_dir/authorized_keys"
    if ! grep -qF "$key" "$authorized_keys_file"; then
        echo "$key" >> "$authorized_keys_file"
        chown "$username:$username" "$authorized_keys_file"
        chmod 600 "$authorized_keys_file"
        echo "Authorized key added for user $username."
    else
        echo "Authorized key for user $username already exists."
    fi
done < "$FILE"

exit 0
