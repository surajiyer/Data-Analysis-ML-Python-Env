# Can only be run from Windows Powershell or Unix terminal!!
# 'cd' into your projects directory before running this script
docker run --name=$(whoami) -d -v .:/home/projects -p 8888:8888 datascience