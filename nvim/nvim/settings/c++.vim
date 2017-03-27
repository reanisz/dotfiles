let $CPP_STDLIB = "/usr/include/c++/"
set path+=$CPP_STDLIB

au BufReadPost $CPP_STDLIB/* if empty(&filetype) | set filetype=cpp | endif
