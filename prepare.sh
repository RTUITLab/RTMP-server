#!/bin/bash
IFS=$'\n'
envs=($(printenv | grep '^CS_'))

nginxProps=()
for i in "${envs[@]}"
do
    name=$(cut -d '=' -f1 <<< $i)
    name=$(sed 's|CS_||' <<< $name)
    nginxProps+=("$name $(cut -d '=' -f2 <<< $i);")
done
output="$(echo ${nginxProps[*]})"
echo $output

template_content=$(cat /nginx-template.conf)

sed_args="s#%template_place%#$output#"
echo $sed_args
sed -i $sed_args /nginx-template.conf
cat /nginx-template.conf
cp /nginx-template.conf etc/nginx/nginx.conf