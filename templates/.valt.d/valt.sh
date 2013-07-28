username=$(awk '$0 ~ /username/ {print $2}' ~/.valtrc)
valt_d_path=$(awk '$0 ~ /valt_d/ {print $2}' ~/.valtrc)

path_to_source="${valt_d_path}/${username}/.valtrc_local"


if [ -e $path_to_source ];then
  source $path_to_source
else
  # Fail silently so we don't annoy non-valt users
fi
