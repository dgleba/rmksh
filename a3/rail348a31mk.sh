#!/usr/bin/env bash
#cd ;
 # set -e will exit on first error. so set -vxe..
date ; set +vx  ; set -vx ; # echo off, then echo on

#
# this
#   rails_admin  material theme tests
#
#
# usage:
#
#   ./rail348a31mk.sh 2>&1 | tee -a rail348a31mk.sh_log$(date +"__%Y-%m-%d_%H.%M.%S").log


appn='rail348a31'



# set appn above.




# new rails app  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ruby -v ; rails -v
rails _5.2.1_ new $appn


if [ ! -d "$appn" ]; then
  # Control will enter here if DIRECTORY doesn't exist.
  echo 'Error! app not created. folder doesn`t exit.'
  #seco=110 ; read -t $seco -p "Hit ENTER or wait $seco seconds"
  exit 9
fi

cd $appn ; pwd

rm -rf .git
git init
git add -A # Add all files and commit them
  git commit -m "Before any changes"

   
  
  
### gemfile.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

echo "# " >> Gemfile

# gem1="gem 'simple_form'"
# echo "$gem1" >> Gemfile

gem1="gem 'select2-rails'"
echo "$gem1" >> Gemfile


echo "gem 'rails_admin'" >> Gemfile

echo "gem 'rails_admin_material'" >> Gemfile

# echo "gem 'rails_admin', :git =>  'https://github.com/dgleba/rails_admin.git'" >> Gemfile


echo "gem 'faker'" >> Gemfile

# 2018-09-21 error:  populate NoMethodError: undefined method `sanitize' 
#echo "gem 'populator'" >> Gemfile
#
# solution..
# https://fulvi0.github.io/fulvi0/2017/how-to-populate-db/
echo "gem 'populator', :github => 'fulvi0/populator'">> Gemfile

echo "# " >> Gemfile

bundle

sleep 2
git add -A # Add all files and commit them
git commit -m "gemfile"




### setup bootstrap assets .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### install 1 .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### modify scaffold templates... ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  

### scaffold... ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


rails g scaffold Product name  pdate:datetime active_status:integer sort:integer -f \

rails g scaffold Pfeature name fdate:datetime active_status:integer sort:integer -f \

rails g scaffold ProductFeature name  product:references pfeature:references active_status:integer sort:integer -f \


sleep 2
git add -A # Add all files and commit them
git commit -m "scaffold"



### db .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#rake db:reset
rake db:drop


bin/rails active_storage:install:migrations


rake db:migrate

bin/rails db:migrate RAILS_ENV=development
 
#rake db:seed





### populate .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


cat << HEREDOC > lib/tasks/populate.rake
namespace :db do
  desc "fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    Product.populate 3 do |a12|
      a12.name     = Faker::Commerce.product_name
    end
    Pfeature.populate 9 do |a12|
      a12.name     = Faker::Commerce.color
    end
  end
end
HEREDOC

# works, but change to rails.. rake db:populate
rails db:populate

sleep 2
git add -A # Add all files and commit them
  git commit -m "populate"

  

### app...js .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### controller.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



### routes.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### view.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  
### application.html.erb .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  
### style the autocomplete.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### admin1 .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
### home page .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  

rails g controller Home index about 
 
#
# add line after match...  sed -i '/CLIENTSCRIPT="foo"/a CLIENTSCRIPT2="hello"' file
# i think 0, means only do it for the first match..
#
pattern1='application.routes'
line1='  root "home#index"'
#line2='  about "home#about"'
replace the entire line matching pattern1...
#sed  -i "0,/$pattern1/a \ \n$line1\n$line2\n\n" config/routes.rb
sed  -i "0,/$pattern1/a \ \n$line1\n\n" config/routes.rb

 
cat << 'HEREDOC' >> app/views/home/index.html.erb

<h3> 1.   </h3>
<%= link_to 'Products', products_path %>
<h3> 2.   </h3>
<%= link_to 'Rails admin', rails_admin.index_path('') %>
<br><br><br>
<hr>
<%= Rails.env %> 

HEREDOC


git add -A # Add all files and commit them
git commit -m "add home page"
  
 
   
   
### admin2 .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
# rails_admin..


# works..
 printf 'radmin\n' | rails g rails_admin:install


sleep 1
git add -A # Add all files and commit them
git commit -m "install  admin"
  
 
 
 
# remove line containing  '[global]'  and replace the line completely with the new text...
#      sed -i 's/.*global].*/[global]\n\nunix extensions = no/g' /etc/samba/smb.conf 
#
patrn1='Rails.application.config.assets.version'
patrn2='Rails.application.config.assets.version = \"1.1\"'
sed -i -e "s/.*$patrn1.*/$patrn2/" config/initializers/assets.rb

# add configs... 
#   sed -i '/CLIENTSCRIPT/a \ \ CLIENTSCRIPT2' file  # add line after pattern - include leading spaces like so - escape them.. '\ '  
patrn='RailsAdmin.config'
addln='\ \ config.total_columns_width = 9999999'
sed -i "/$patrn/a$addln" config/initializers/rails_admin.rb





sleep 1
git add -A # Add all files and commit them
git commit -m "configure customized  admin"
  
  
# material.. 
#
# add line after match...  sed -i '/CLIENTSCRIPT="foo"/a CLIENTSCRIPT2="hello"' file
# i think 0, means only do it for the first match..
#
pattern1='Bundler.require'
line1="  ENV['RAILS_ADMIN_THEME'] = 'material'"
# replace the entire line matching pattern1...
# sed  -i "0,/$pattern1/a \ \n$line1\n\n" config/application.rb 
sed  -i "/$pattern1/a \ \n$line1\n\n" config/application.rb 
 
 
mkdir -p app/assets/javascripts/rails_admin/custom
echo '//= require rails_admin/themes/material/ui.js' >> app/assets/javascripts/rails_admin/custom/ui.js
   


sleep 1
git add -A # Add all files and commit them
git commit -m "configure rails_admin material theme."
    
  
 
### disable turbolinks .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 
# originally... 
  # <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  # <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
 
   
sleep 1
git add -A # Add all files and commit them
git commit -m "disable turbolinks"



 
 
### enable select2 .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 
function comments21() {
# begin block comment =============================
: <<'END'


  
  
END
# end block comment ===============================
} 





 

### finish up.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sleep 1
git add -A # Add all files and commit them
git commit -m "reached end of script"

set +vx
pwd
echo  '----------------------------------------> Note ---  Reached end of file!!!'
echo  run rails s
echo  then visit localhost:3000/
echo  then visit localhost:3000/products
date
#

