#!/bin/sh

init_target anyenv

process_anyenv(){
    github riywo/anyenv .anyenv
    directory .anyenv/plugins
    github znz/anyenv-update.git .anyenv/plugins/anyenv-update
}
