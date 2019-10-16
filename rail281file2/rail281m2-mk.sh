#!/usr/bin/env bash
#cd ; 
date ; set +vx  ; set -vx ; # echo off, then echo on


#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Summary: this works.
#
# jquery-autocomplete  autocomplete for rails 5.2.3 for countryoforigins and products


#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# usage: 
# copy ..../rail281file/* var/share203/rail281file
# input files will be in var/share203/rail281file folder.
# cd /home/albe/share203
#       rail281file/rail281j-mk.sh
# The output will be that it creates  var/share203/rail281e/*
#
#  Usage:       cd /srv/file/test/brails/mkw/rmksh ; a=rail281m-mk ; chmod +x rail281file2/${a}.sh ; rail281file2/${a}.sh 2>&1 | tee -a rail_${a}.sh_log$(date +"__%Y-%m-%d_%H.%M.%S").log



# edit these variables before running..

appn='m04rail281'

sfil='../rail281file2'





#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# new rails app  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


gem install rails -v 5.2.3 --no-document


rails  _5.2.3_ new $appn

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

rails g scaffold CountryOfOrigin name ctype fdate:datetime active_status:integer sort_order:integer -f

rails g scaffold Pfeature name fdate:datetime active_status:integer sort_order:integer -f


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

echo 'Pfeature.create({name: "green"}) '>> db/seeds.rb
echo 'Pfeature.create({name: "blue"}) '>> db/seeds.rb
echo 'Pfeature.create({name: "pink"}) '>> db/seeds.rb
echo 'Pfeature.create({name: "white"}) '>> db/seeds.rb



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




# application.html.erb  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#    just before /head. ...
#    add...  <%= javascript_include_tag "autocomplete-rails.js" %>'
pattern1='\/head>'
# some characters are escaped below... \<  \" \>
line1='  \<%= javascript_include_tag \"autocomplete-rails.js\" %\>'
sed  -ie "/${pattern1}/i $line1\n"  app/views/layouts/application.html.erb



r1="app/views/layouts/application.html.erb"
cat << 'HEREDOC' >> $r1
<hr>
<%= link_to 'Country of Origin list', country_of_origins_path, class: "btn btn-primary", :style=>'color:red;' %>
<%= link_to 'Products', products_path, class: "btn btn-primary", :style=>'color:blue;' %>
<hr>
HEREDOC


# Asset was not declared to be precompiled in production.
# Add `Rails.application.config.assets.precompile += %w( autocomplete-rails.js )` to `config/initializers/assets.rb` and restart your server
echo 'Rails.application.config.assets.precompile += %w( autocomplete-rails.js )'>> config/initializers/assets.rb
  

git add -A # Add all files and commit them
  git commit -m "five"


###
# style the autocomplete.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  

cp $sfil/dgautocomplete.scss app/assets/stylesheets




# app specific . ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# app specific . ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# app specific . ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# app specific js file .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# copy the js file..


r1="app/assets/javascripts/products_ac.js"
cat << 'HEREDOC' > $r1
$(function() {
  
  // run when eventlistener is triggered
  // http://stackoverflow.com/questions/6431459/jquery-autocomplete-trigger-change-event
  //
  $("#product_type_name").on( "autocompletechange", function(event,data) {
     // post value to console for validation
     console.log("Item is: ", $(this).val());

    // if item user typed in the input box is not in the list of suggestions, it will be cleared out. The user must select an item.
    if (!data.item) {
        this.value = '';
        console.log('> Item selected is:', data.item);
        }
        
    });   
    console.log ("msg.. 1012")  
     
});
HEREDOC

git add -A # Add all files and commit them
  git commit -m "product"


--

# copy the js file..


r1="app/assets/javascripts/products_ac.js"
cat << 'HEREDOC' > $r1
$(function() {
  
  // run when eventlistener is triggered
  // http://stackoverflow.com/questions/6431459/jquery-autocomplete-trigger-change-event
  //
  $("#country_of_origin_ctype").on( "autocompletechange", function(event,data) {
     // post value to console for validation
     console.log("Item is: ", $(this).val());

    // if item user typed in the input box is not in the list of suggestions, it will be cleared out. The user must select an item.
    if (!data.item) {
        this.value = '';
        console.log('> Item selected is:', data.item);
        }
        
    });   
    console.log ("msg.. 91017")  
     
});
HEREDOC

git add -A # Add all files and commit them
  git commit -m "ccjs"




  
#controller.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# add this lines after match in controller....
  # class ProductsController < Admin::BaseController
    # ..this line..  autocomplete :type, :name
  # end  
#
  #eg:  sed -i '/CLIENTSCRIPT/i \ \ CLIENTSCRIPT2' file  # add line before pattern - include leading spaces like so - escape them.. '\ '  
  
line1='  autocomplete :type, :name, :full => true'
sed -i "/before_action/a  \  #\n$line1\n"  app/controllers/products_controller.rb 
  

# country_of_origins

line1='  autocomplete :pfeature, :name, :full => true'
sed -i "/before_action/a  \  #\n$line1\n"  app/controllers/country_of_origins_controller.rb 
  


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
 

# country_of_origins


pattern1='resources :country_of_origins'
line1='  resources :country_of_origins do'
line2='    get :autocomplete_pfeature_name, :on => :collection'
line3='  end'
  sed  -i "0,/$pattern1/s/.*$pattern1.*/#\n$line1\n$line2\n$line3\n/" config/routes.rb 
 

 
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



# country_of_origins


pattern1='form.text_field :ctype'
file21=app/views/country_of_origins/_form.html.erb
if ! grep -q "${pattern1}" $file21 ; then 
  echo nogrep ~164 ; sleep 9 ; exit 9 ; 
fi
line1="   <%= form.autocomplete_field :ctype, autocomplete_pfeature_name_country_of_origins_path , \'min-length\' => 1 , \'data-auto-focus\' => true %>"
  sed  -i "0,/$pattern1/s/.*$pattern1.*/$line1\n/" $file21





# finish up.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

git add -A # Add all files and commit them
  git commit -m "finish1"

pwd   
echo  run rails s
echo  then visit localhost:3000/products
date
#

