





if command -v uv &> /dev/null; then
    # uv 的补全脚本会调用 compdef,需要先加载补全系统
    (( $+functions[compdef] )) || { autoload -Uz compinit && compinit; }
    eval "$(uv generate-shell-completion zsh)"
fi


### JAVA
# 必须 export，否则 pnpm/tauri/gradlew 等子进程读不到，Tauri CLI 会回退到
# Android Studio 的 JBR(25)，而 Gradle kotlin-dsl 内置的 Kotlin 2.0.21 解析不了
# JDK 25 版本号（IllegalArgumentException: 25.0.4），Android 构建的 buildSrc 直接失败。
export JAVA_HOME=$(/usr/libexec/java_home -v 21)


### ANDROID
# 配置 ANDROID_HOME
export ANDROID_HOME=$HOME/Library/Android/sdk
# 配置 NDK_HOME (请根据你实际安装的 NDK 版本目录修改具体的版本号)
export NDK_HOME=$ANDROID_HOME/ndk/30.0.16248370
# 将相关工具路径加入 PATH
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$NDK_HOME
