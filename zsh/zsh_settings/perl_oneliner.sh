function filter(){
    cat - | perl -nle "print if ( sub{ $@ }->() );"
}

function transform(){
    cat - | perl -nle "print sub{ $@ }->();"
}
