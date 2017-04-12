# Modified from the nim.fish prompt: https://github.com/nim65s/dotfiles/

function fish_prompt
    and set retc green; or set retc red

    set_color $retc
    echo -n '┬─'
    set_color -o green
    echo -n [
    if [ $USER = root ]
        set_color -o red
    else
        set_color -o yellow
    end
    echo -n $USER
    set_color -o white
    echo -n @
    if [ -z "$SSH_CLIENT" ]
        set_color -o blue
    else
        set_color -o cyan
    end
    echo -n (hostname)
    set_color -o white
    echo -n :(pwd|sed "s=$HOME=~=")
    set_color -o green
    echo -n ']'
    set_color normal
    set_color $retc
    echo -n '─'
    set_color -o green
    echo -n '['
    set_color normal
    set_color $retc
    echo -n (date +%X)
    set_color -o green
    echo -n ]

    # Git branch
    set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
    if not test -z $branch
        set_color $retc
        echo -n '─'
        set_color -o green
        echo -n '['
        set_color normal
        echo -n $branch
        set -l dirtyIndex (git diff-index --quiet HEAD --)
        if test $status -ne 0
            echo -n '*'
        end
        set_color -o green
        echo -n ']'
    end

    if set -q VIRTUAL_ENV
        echo -n '─'
        set_color -o green
        echo -n '['
        echo -n -s (set_color white) (basename "$VIRTUAL_ENV") (set_color normal)
        set_color -o green
        echo -n ']'
    end

    echo

    for job in (jobs)
        set_color $retc
        echo -n '│ '
        set_color brown
        echo $job
    end

    set_color normal
    set_color $retc
    echo -n '╰─>'
    set_color -o red
    echo -n '$ '
    set_color normal
end
