function git-prevbranch(){
    git rev-parse --abbrev-ref '@{-1}'
}
function git-nowbranch(){
    git rev-parse --abbrev-ref '@{-1}'
}

function git-mergeprev(){
    git merge `git-prevbranch` --no-ff
}
