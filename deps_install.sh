RED='\033[0;31m'
ORANGE='\033[0;33m'
NC='\033[0m'

if [ -d "libft/" ]; then
  cd libft/
  git stash
  git checkout master
  if [[ ${FT_SSL_DEPS_UPDATE} = "false" ]]; then
    printf "${ORANGE}[WARN] Skipping libft update${NC}\n"
    exit 0
  fi
  git pull origin master
else
  if [[ ${FT_SSL_DEPS_UPDATE} = "false" ]]; then
    printf "${RED}[ERROR] Libft has not be fetched.${NC}\n"
    exit 1
  fi
  git clone https://github.com/sganon/libft.git
fi
