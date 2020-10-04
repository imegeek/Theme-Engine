#!/usr/bin/bash

connected_to_internet() {
  test_urls="\
  https://www.google.com/ \
  "

  processes="0"
  pids=""

  for test_url in $test_urls; do
    curl --silent --head "$test_url" > /dev/null &
    pids="$pids $!"
    processes=$(($processes + 1))
  done

  while [ $processes -gt 0 ]; do
    for pid in $pids; do
      if ! ps | grep "^[[:blank:]]*$pid[[:blank:]]" > /dev/null; then
        # Process no longer running
        processes=$(($processes - 1))
        pids=$(echo "$pids" | sed --regexp-extended "s/(^| )$pid($| )/ /g")

        if wait $pid; then
          # Success! We have a connection to at least one public site, so the
          # internet is up. Ignore other exit statuses.
          kill -TERM $pids > /dev/null 2>&1 || true
          wait $pids
          return 0
        fi
      fi
    done
    # wait -n $pids # Better than sleep, but not supported on all systems
  done

  return 1
}

if connected_to_internet; then
update_banner() {
cd $HOME; wget https://raw.githubusercontent.com/abhackerofficial/theme-engine/master/program-files/zsh.info -q; }
show_banner() { cd $HOME ; bash zsh.info ; rm zsh.info ; }

command -v git > /dev/null 2>&1 || { pkg install git -y ; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed, Now Installing."; apt install wget -y ; }

update_files() {
cd $HOME
rm -rf .oh-my-zsh
rm -rf .zsh-syntax-highlighting
if [ -f "/data/data/com.termux/files/home/theme-engine/fonts/fonts.rar" ];then
cd /data/data/com.termux/files/home/theme-engine/fonts
unrar x fonts.rar > /dev/null 2>&1
rm -rf fonts.rar ;fi
cd /data/data/com.termux/files/home/theme-engine
cp -rf .oh-my-zsh .zsh-syntax-highlighting /data/data/com.termux/files/home ;cd
cd /data/data/com.termux/files/home/theme-engine
cp -rf colors fonts /data/data/com.termux/files/home/.termux ;cd
cd /data/data/com.termux/files/home/theme-engine/program-files
cp colors.theme fonts.theme zsh.theme zsh.update /data/data/com.termux/files/home/.termux
cd /data/data/com.termux/files/home/.termux
chmod +x colors.theme fonts.theme zsh.theme zsh.update
cd $HOME
}

changed=0
git remote update &> /dev/null && git status -uno | grep -q 'Your branch is behind' && changed=1
if [ $changed = 1 ]; then
if [ -d "/data/data/com.termux/files/home/theme-engine" ];then
     DIR() { cd /data/data/com.termux/files/home/theme-engine ; }
     update_banner; DIR; git pull
     update_files
     show_banner
else
     cd $HOME
     trap '' 2
     git clone https://github.com/abhackerofficial/theme-engine "/data/data/com.termux/files/home/theme-engine";update_banner ;sleep 2
     sleep 1 ;cd theme-engine;chmod +x theme.engine ;
     trap 5
     update_files
     show_banner
fi
else
    echo "Oh-my-zsh Already ! Updated"
fi
else
echo 'No internet connection available !'
fi

