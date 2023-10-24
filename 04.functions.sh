print_hello() {
  echo hello world
}

print_hello

print_arguments() {
  echo first Argument $1
  echo second Argument $2
  echo all Arguments - $*
  echo no of Arguments - $#
}
prnit_arguments abc 123 xyz