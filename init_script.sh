#!/bin/bash
containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

ignore_files=(".git" ".gitignore" "init_script.sh")
shopt -s dotglob
for file in *
do
  containsElement "$file" "${ignore_files[@]}"
  if [ $? == 1 ]; then
    echo "$file"
    ln -sf "${PWD}/$file" "${HOME}/"
  fi
done

# install tmux plugin
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install vim plugin
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
