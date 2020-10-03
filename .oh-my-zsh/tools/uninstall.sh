#!/usr/bin/bash

if [ -f "/data/data/com.termux/files/home/.termux/main.theme.engine" ];then
if [ -f "/data/data/com.termux/files/home/.zshrc" ];then cd $HOME ; rm .zshrc ;fi
if [ -d "/data/data/com.termux/files/home/.oh-my-zsh" ];then cd $HOME ;rm -rf .oh-my-zsh ;fi
if [ -f "/data/data/com.termux/files/home/.termux/shell" ];then cd $HOME/.termux ; rm shell ;fi
if [ -f "/data/data/com.termux/files/home/.termux/main.theme.engine" ];then
cd /data/data/com.termux/files/home/.termux; rm main.theme.engine ;fi
if [ -d "/data/data/com.termux/files/home/.zsh-syntax-highlighting" ];then cd $HOME ; rm -rf .zsh-syntax-highlighting ;fi
echo "[√] Uninstalled Oh-my-zsh Successfully"
kill -9 $PPID
else
echo "[!] You won't disable (Zsh) before Enable Zsh-Theme" ;fi
