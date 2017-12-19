#!/bin/bash

git checkout master && git push origin master
git checkout php7.2 && git rebase master && git push origin php7.2 -f
git checkout php7.1 && git rebase master && git push origin php7.1 -f
git checkout php7.0 && git rebase master && git push origin php7.0 -f
git checkout php5.6 && git rebase master && git push origin php5.6 -f
git checkout master && git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit --all
