@echo off

if [%1]==[] goto noarg

echo on
rm -R --force public\docs
mkdir public\docs
echo developer.mycontributes.com > public\docs\CNAME
@pause
hugo
@pause
git add .
git commit -m %1
@pause
git push origin master
@goto done

:noarg
echo Use: %0 "commit message"

:done
