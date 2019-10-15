#!/usr/bin/env bash
#cd ; 
date ; set +vx  ; set -vx ; # echo off, then echo on

# this works.
#
# jquery-autocomplete  autocomplete for rails 4

# usage: 
# copy ..../rail281file/* var/share203/rail281file
# input files will be in var/share203/rail281file folder.
# cd /home/albe/share203
#       rail281file/rail281j-mk.sh
# The output will be that it creates  var/share203/rail281e/*
#
#    cd /srv/file/test/brails/_rmksh ; a=rail281j-mk ; chmod +x rail281file/${a}.sh ; rail281file/${a}.sh 2>&1 | tee -a rail_${a}.sh_log$(date +"__%Y-%m-%d_%H.%M.%S").log


appn='j14rail281'

sfil='../rail281file'



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




# new rails app  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


gem install rails -v 5.1.6 --no-document


rails  _5.1.6_ new $appn

if [ ! -d "$appn" ]; then
  # Control will enter here if DIRECTORY doesn't exist.
  set +vx
  echo 'Error 9!  - app not created. folder doesn`t exist after attempting to create it.'
  #seco=110 ; read -t $seco -p "Hit ENTER or wait $seco seconds"
  exit 9
fi
cd $appn ; pwd


rm -rf .git 
git init
git add -A # Add all files and commit them 
  git commit -m "Before any changes"

# gemfile.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  
echo "# https://github.com/bigtunacan/rails-jquery-autocomplete" >> Gemfile
echo "# https://github.com/yifeiwu/rails4-autocomplete-demo" >> Gemfile
echo "gem 'rails-jquery-autocomplete'" >> Gemfile
echo "gem 'jquery-rails'" >> Gemfile
echo "gem 'jquery-ui-rails'" >> Gemfile

bundle

git add -A # Add all files and commit them
git commit -m "two"


pwd

### install .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

rails generate autocomplete:install

 
git add -A # Add all files and commit them
git commit -m "three"
 
# scaffold... ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


 
rails g scaffold Product name type_name comment \
 -f
rails g scaffold Type name active:boolean \
 -f

git add -A # Add all files and commit them
git commit -m "scaffold"

# db ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


echo 'Type.create({name: "Christie"}) '>> db/seeds.rb
echo 'Type.create({name: "Xerox"}) '>> db/seeds.rb
echo 'Type.create({name: "Burns"}) '>> db/seeds.rb
echo 'Type.create({name: "Mr. Christies"}) '>> db/seeds.rb
echo 'Type.create({name: "Cities"}) '>> db/seeds.rb
echo 'Type.create({name: "Three Cities"}) '>> db/seeds.rb
echo 'Type.create({name: "Carob Charob"}) '>> db/seeds.rb

#rake db:reset
rake db:drop:all
rake db:migrate ; rake db:seed

###

# app...js  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#eg:  sed -i '/CLIENTSCRIPT/i \ \ CLIENTSCRIPT2' file  # add line before pattern - include leading spaces like so - escape them.. '\ '  
sed -i '/require_tree/i  \ //= require jquery \n //= require jquery-ui \n //= require autocomplete-rails'  app/assets/javascripts/application.js

###

git add -A # Add all files and commit them
  git commit -m "four"

###
  
#controller.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# add this lines after match in controller....
  # class ProductsController < Admin::BaseController
    # ..this line..  autocomplete :type, :name
  # end  
#
  #eg:  sed -i '/CLIENTSCRIPT/i \ \ CLIENTSCRIPT2' file  # add line before pattern - include leading spaces like so - escape them.. '\ '  
  
line1='  autocomplete :type, :name, :full => true'
sed -i "/before_action/a  \  #\n$line1\n"  app/controllers/products_controller.rb 
  

  
#routes.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  # resources :products do
    # get :autocomplete_type_name, :on => :collection
  # end  
pattern1='resources :products'
line1='  resources :products do'
line2='    get :autocomplete_type_name, :on => :collection'
line3='  end'
line4='  root "products#index"'
# x x sed -i "/resources :products/a  \  #\n$line1\n$line2\n$line3\n"  config/routes.rb
# sed '0,/pattern/s/pattern/replacement/' filename  ##  stackoverflow.com/questions/148451/how-to-use-sed-to-replace-only-the-first-occurrence-in-a-file
# replace the entire line matching pattern1...
  sed  -i "0,/$pattern1/s/.*$pattern1.*/#\n$line1\n$line2\n$line3\n$line4\n/" config/routes.rb 
 
 
# view.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  # f.autocomplete_field :type_name, autocomplete_type_name_products_path 
    # was.. <%= f.text_field :type1 %>
#
# multiple autocomplete... use this option... 'data-delimiter' => ','
#
pattern1='form.text_field :type_name'
file21=app/views/products/_form.html.erb
if ! grep -q "${pattern1}" $file21 ; then 
  echo nogrep ~164 ; sleep 9 ; exit 9 ; 
fi
#line1='   <%= form.autocomplete_field :type_name, autocomplete_type_name_products_path , \'min-length\' => 1 , \'data-auto-focus\' => true %>'  
line1="   <%= form.autocomplete_field :type_name, autocomplete_type_name_products_path , \'min-length\' => 1 , \'data-auto-focus\' => true %>"
  sed  -i "0,/$pattern1/s/.*$pattern1.*/$line1\n/" $file21


# application.html.erb  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#    just before /head. ...
#    add...  <%= javascript_include_tag "autocomplete-rails.js" %>'
pattern1='/head>'
# some characters are escaped below... \<  \" \>
line1='  \<%= javascript_include_tag \"autocomplete-rails.js\" %\>'
sed  -i "/$pattern1/i \ \  $line1\n"  app/views/layouts/application.html.erb


# Asset was not declared to be precompiled in production.
# Add `Rails.application.config.assets.precompile += %w( autocomplete-rails.js )` to `config/initializers/assets.rb` and restart your server
echo 'Rails.application.config.assets.precompile += %w( autocomplete-rails.js )'>> config/initializers/assets.rb
  

git add -A # Add all files and commit them
  git commit -m "five"


###
# style the autocomplete.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  

cp $sfil/dgautocomplete.scss app/assets/stylesheets
cp $sfil/product1.js app/assets/javascripts

git add -A # Add all files and commit them
  git commit -m "six"

# finish up.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
pwd   
echo  run rails s
echo  then visit localhost:3000/products
date
#

