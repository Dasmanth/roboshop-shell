print_hello() {
  echo hello world
}

print_hello

print_arguments() {
  echo first argument $1
  echo second argument $2
  echo all arguments - $*
  echo no of arguments - $#
}

prnit_arguments abc 123 xy