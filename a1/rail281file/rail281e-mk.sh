#!/usr/bin/env bash
#cd ; 
date ; set +vx  ; set -vx ; # echo off, then echo on
#
# yui autocomplete

# usage: 
# copy ..../rail281file/* var/share203
# cd var/share203
# rail281file/rail281e-mk.sh
# The result will be that it creates  var/share203/rail281e/*
#

sfil='../rail281file'
appn='rail281e'

rails new $appn
cd $appn
pwd

rm -rf .git 
git init
git add -A # Add all files and commit them 
  git commit -m "Before any changes"

echo "# https://github.com/bigtunacan/rails-jquery-autocomplete" >> Gemfile
echo "# https://github.com/yifeiwu/rails4-autocomplete-demo" >> Gemfile
echo "gem 'rails-jquery-autocomplete'" >> Gemfile
echo "gem 'jquery-ui-rails'" >> Gemfile

bundle

rm -rf .git 
git init
git add -A # Add all files and commit them
git commit -m "First"

rails generate autocomplete:install

pwd

###
 
git add -A # Add all files and commit them
git commit -m "2"
 
rails g scaffold Product name brand_name comment \
 -f
rails g scaffold Brand name  \
 -f

git add -A # Add all files and commit them
git commit -m "3"

echo 'Brand.create({name: "Christie"}) '>> db/seeds.rb
echo 'Brand.create({name: "Xerox"}) '>> db/seeds.rb
echo 'Brand.create({name: "Burns"}) '>> db/seeds.rb

#rake db:reset
rake db:drop:all
rake db:migrate ; rake db:seed

###

#eg:  sed -i '/CLIENTSCRIPT/i \ \ CLIENTSCRIPT2' file  # add line before pattern - include leading spaces like so - escape them.. '\ '  
sed -i '/require_tree/i  \ //= require jquery-ui/autocomplete \n //= require autocomplete-rails'  app/assets/javascripts/application.js

###

git add -A # Add all files and commit them
  git commit -m "4"

###
  
# add this lines after match in controller....
#controller..
  # class ProductsController < Admin::BaseController
    # ..this line..  autocomplete :brand, :name
  # end  
line1='  autocomplete :brand, :name, :full => true'
sed -i "/before_action/a  \  #\n$line1\n"  app/controllers/products_controller.rb
  

  
#routes..
  # resources :products do
    # get :autocomplete_brand_name, :on => :collection
  # end  
pattern1='resources :products'
line1='  resources :products do'
line2='    get :autocomplete_brand_name, :on => :collection'
line3='  end'
# x x sed -i "/resources :products/a  \  #\n$line1\n$line2\n$line3\n"  config/routes.rb
# sed '0,/pattern/s/pattern/replacement/' filename  ##  stackoverflow.com/questions/148451/how-to-use-sed-to-replace-only-the-first-occurrence-in-a-file
  sed  -i "0,/$pattern1/s/.*$pattern1.*/#\n$line1\n$line2\n$line3\n/" config/routes.rb 
 
 
# view..
  # f.autocomplete_field :brand_name, autocomplete_brand_name_products_path 
    # was.. <%= f.text_field :brand1 %>
pattern1='f.text_field :brand_name'
line1='   <%= f.autocomplete_field :brand_name, autocomplete_brand_name_products_path %>'  
  sed  -i "0,/$pattern1/s/.*$pattern1.*/$line1\n/" app/views/products/_form.html.erb


#eg:  sed -i '/CLIENTSCRIPT/i \ \ CLIENTSCRIPT2' file  # add line before pattern - include leading spaces like so - escape them.. '\ '  

# application.html.erb
#    </title>
#    add...  <%= javascript_include_tag "autocomplete-rails.js" %>'
pattern1='title>'
line1='  \<%= javascript_include_tag \"autocomplete-rails.js\" %\>'
sed  -i "/$pattern1/a \ \  $line1\n"  app/views/layouts/application.html.erb


# Asset was not declared to be precompiled in production.
# Add `Rails.application.config.assets.precompile += %w( autocomplete-rails.js )` to `config/initializers/assets.rb` and restart your server
echo 'Rails.application.config.assets.precompile += %w( autocomplete-rails.js )'>> config/initializers/assets.rb
  
###
  
pwd   
echo  run rails s
echo  then visit localhost:3000/posts
date
#

git add -A # Add all files and commit them
  git commit -m "5"

# git config --global user.name "David Gleba"
# git config --global user.email dgleba@gmail.com

cp $sfil/dgautocomplete.scss app/assets/stylesheets

git add -A # Add all files and commit them
  git commit -m "6"

  