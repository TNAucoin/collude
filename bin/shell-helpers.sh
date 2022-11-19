#!/usr/bin/env bash

# Color variables
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Spacing variables
export TAB='  '
export TABx2='    '

# Function to handle exiting with an error.
die() {
  echo_red >&2 "$@"
  exit 1
}

# Wrap a string in blue escape code.
blue() {
  local var="${BLUE}$1${NC}"
  echo "$var"
}

# Wrap a string in green escape code.
green() {
  local var="${GREEN}$1${NC}"
  echo "$var"
}

# Wrap a string in red escape code.
red() {
  local var="${RED}$1${NC}"
  echo "$var"
}

# Wrap a string in yellow escape code.
yellow() {
  local var="${YELLOW}$1${NC}"
  echo "$var"
}

# Function used to color echo text in blue.
echo_blue() {
  echo -e "$(blue "$1")"
}

# Function used to color echo text in green.
echo_green() {
  echo -e "$(green "$1")"
}

# Function used to color echo text in red.
echo_red() {
  echo -e "$(red "$1")"
}

# Function used to color echo text in yellow.
echo_yellow() {
  echo -e "$(yellow "$1")"
}

# Print a box table header.
echo_boxheader() {
  echo -e "┌─ $1"
}

# Print a box table line item.
echo_boxbody() {
  echo -e "├─── $1"
}

# Print a box table footer.
echo_boxfooter() {
  echo -e "└─ $1"
}

# Checks to see if a docker container is currently running on your machine.
container_is_running() {
  # Check for input
  [ $# -ne 1 ] && echo 'Pass only one container name' && return

  # Check if container is running
  docker ps -q -f name=^/"$1"$
}

# Check if a command exists on the system.
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check for a list of required commands. Exit 1 if any requirement is missing.
required_commands() {
  echo_boxheader "Checking for REQUIRED packages..."

  local success=true
  arr=("$@")
  for i in "${arr[@]}";
    do
      if command_exists "$i";
      then
        echo_boxbody "'$i' found."
      else
        echo_boxbody "$(yellow "'$i' is required but not available.")"
        success=false
      fi
    done

    if $success
    then
      echo_boxfooter "$(green "Required packages check complete.")"
    else
      echo_boxfooter "$(red "Required packages check failed!")"
      exit 1
    fi
}

# Check for a list of recommended commands.
recommended_commands() {
  echo_boxheader "Checking for RECOMMENDED packages..."

  local success=true
  arr=("$@")
  for i in "${arr[@]}";
    do
      if command_exists "$i";
      then
        echo_boxbody "'$i' found."
      else
        echo_boxbody "$(yellow "'$i' is recommended but not available.")"
        success=false
      fi
    done

    if $success
    then
      echo_boxfooter "$(green "Recommended packages check complete.")"
    else
      echo_boxfooter "$(yellow "Recommended packages check failed!")"
    fi
}