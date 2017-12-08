#!/usr/bin/env bash
#cd ; 
date ; set +vx  ; set -vx ; # echo off, then echo on
#
# just a test using rail263, i think, but it doesn't matter.

# usage: 
# copy ..../rail281file/* var/share203/rail281file
# files will be in var/share203/rail281file folder.
# cd var/share203
# run..      rail281file/rail281e-mk.sh
# The output will be that it creates  var/share203/rail281e/*


#   rail281file/rail281b2-mk.sh


appn='rail281b2'

sfil='../rail281file'

# new rails app  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# gemfile.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

pwd

### install .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 
# scaffold... ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 
rails g scaffold Alist name catgry:references comment \
 -f
rails g scaffold catgry name  \
 -f


# db ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


rake db:drop:all
rake db:migrate ; rake db:seed

###

# app...js  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#eg:  sed -i '/CLIENTSCRIPT/i \ \ CLIENTSCRIPT2' file  # add line before pattern - include leading spaces like so - escape them.. '\ '  

###
  
#controller.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


 #eg:  sed -i '/CLIENTSCRIPT/i \ \ CLIENTSCRIPT2' file  # add line before pattern - include leading spaces like so - escape them.. '\ '  
  
  
#routes.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


 
# view.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# application.html.erb  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




###
# style the autocomplete.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  



# finish up.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  

