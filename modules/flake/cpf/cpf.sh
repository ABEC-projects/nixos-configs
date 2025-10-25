files=()
for f in "$@"; do
    abs_path=$(realpath "${f}")
    files+=("file://${abs_path} ")
done
if [ -n "$WAYLAND_DISPLAY" ]; then
    copy_plain="wl-copy -t text/plain"
    copy_uri="wl-copy -t text/uri-list"
else
    copy_plain="xclip -i -sel c -t text/plain"
    copy_uri="xclip -i -sel c -t text/uri-list"
fi
list=$(echo "${files[@]}" | sed 's/ file:\/\//\r\nfile:\/\//g')
echo "$list" | $copy_plain
echo "$list" | $copy_uri
