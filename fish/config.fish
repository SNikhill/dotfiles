if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

set CAPACITOR_ANDROID_STUDIO_PATH /usr/bin/android-studio
export CAPACITOR_ANDROID_STUDIO_PATH

set JAVA_HOME $HOME/softwares/jdk1.8.0_311/
export JAVA_HOME

set ANDROID_SDK_ROOT $HOME/Android/Sdk
export ANDROID_SDK_ROOT

set ANDROID_HOME $HOME/Android/Sdk
export ANDROID_HOME

set PATH $PATH $ANDROID_SDK_ROOT/tools/bin $ANDROID_SDK_ROOT/platform-tools $ANDROID_SDK_ROOT/emulator

export PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
## FUNDLE PLUGINS
fundle plugin 'danhper/fish-ssh-agent'

