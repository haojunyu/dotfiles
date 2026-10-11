





if command -v uv &> /dev/null; then
    # uv 的补全脚本会调用 compdef,需要先加载补全系统
    (( $+functions[compdef] )) || { autoload -Uz compinit && compinit; }
    eval "$(uv generate-shell-completion zsh)"
fi
