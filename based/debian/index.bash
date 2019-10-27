cat >>~/.inputrc<<EOF

# Be 8 bit clean.
set input-meta on
set output-meta on

# alternate mappings for "page up" and "page down" to search the history
"\\e[5~": history-search-backward
"\\e[6~": history-search-forward
EOF
