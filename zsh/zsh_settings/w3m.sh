function ggr() {
    local str opt
    if [ $ != 0 ]
    then
        for i in $*
        do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
        opt='search?num=50&hl=ja&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
}
function ejje() {
    local str opt
    if [ $ != 0 ]
    then
        for i in $*
        do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
    fi
    w3m +50 http://ejje.weblio.jp/content/$str
}
