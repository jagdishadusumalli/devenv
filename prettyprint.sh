bold=$(tput bold)
ul=$(tput smul)
rul=$(tput rmul)
blue=$(tput setaf 4)
green=$(tput setaf 5)
normal=$(tput sgr0)

pp() {
  printf "${blue}${bold}\n%b\n\n${normal}" "$1"
}