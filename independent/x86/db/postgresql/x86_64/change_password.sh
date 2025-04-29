#!/bin/bash

if ! command -v psql &>/dev/null; then
  echo "No pgsql client found."
  exit 1
fi

function check_password_complexity() {
  local password=$1
  if [[ ${#password} -lt 8 ]]; then
    echo "Password length must be at least 8 characters."
    return 1
  fi
  if ! [[ "$password" =~ [0-9] ]]; then
    echo "Password must contain at least one number."
    return 1
  fi
  if ! [[ "$password" =~ [A-Z] ]]; then
    echo "Password must contain at least one uppercase letter."
    return 1
  fi
  if ! [[ "$password" =~ [a-z] ]]; then
    echo "Password must contain at least one lowercase letter."
    return 1
  fi
  if ! [[ "$password" =~ [\@\#\$\%\^\&\*\(\)\_\+\!\~] ]]; then
    echo "Password must contain at least one special character like @#$%^&*()_+!~."
    return 1
  fi
  return 0
}

main() {
  local db_name=$1
  while true; do
    read -p "Enter new Database password (Password must be at least 8 characters long and include uppercase letters, lowercase letters, numbers, and special characters.): " -rs new_password
    echo
    if check_password_complexity "$new_password"; then
      break
    else
      echo "Password does not meet complexity requirements. Please try again."
    fi
  done
  if echo "ALTER USER postgres WITH PASSWORD '$new_password';" | psql -h "$db_name" -U postgres; then
    echo "Password changed!"
  else
    echo "Failed to change the password. Check the user name and database connection information."
    exit 1
  fi
}

main "$@"
