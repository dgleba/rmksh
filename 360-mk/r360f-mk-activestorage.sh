#!/usr/bin/env bash







# status. works to a degree. It isn't finished, but works to this point.

# see pmdsdata4 /srv /share













#cd ;
 # set -e will exit on first error. so set -vxe..
date ; set +vx  ; set -vx ; # echo off, then echo on

# based from C:\n\Dropbox\csd\serve\rmksh\a3\rail348a32mk.sh

# on pmdsdata4

#
# this
#   rails active storage attachments
#
#
# usage:
#
#   appn='rac360f5'; chmod +x  ./r360f-mk-activestorage.sh ; ./r360f-mk-activestorage.sh 2>&1 | tee -a $appn.sh_log$(date +"__%Y-%m-%d_%H.%M.%S").log

    appn='rac360f6'





# set appn twice above.






#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Notes


# rails active storage

# # rails new rac360c --dev --force
# # [!] There was an error while loading `thread_safe.gemspec`: uninitialized constant ThreadSafe
# # Did you mean?  Threadsafe. Bundler cannot continue.


# on pdata4 sftp://albe@10.4.1.227/srv/share/_mksh/rac360d


# follow this, with  exceptions below..

  # https://afreshcup.com/home/2017/07/23/activestorage-samples
  # https://github.com/ffmike/activestorage_sample
  

  
      # ref. 
      
      # https://www.engineyard.com/blog/active-storage
            
            # https://gorails.com/episodes/file-uploading-with-activestorage-rails-5-2
              # <% if upload.variable? %>

              
      # https://stackoverflow.com/questions/49515529/rails-5-2-active-storage-purging-deleting-attachements

# https://edgeguides.rubyonrails.org/active_storage_overview.html


# https://github.com/rails/rails/issues/35817
#   rails 6 removes existing attachemnts when adding another - editing.


#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






# new rails app  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 2019-10-07 created rails v6 app..

ruby -v ; rails -v

# rails _5.2.1_ new $appn
 rails  new $appn --no-ri --no-rdoc


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

   
bin/rails active_storage:install
  
# rake db:migrate

  
  
### gemfile.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

bundle

rails g scaffold User name  pdate:datetime active_status:integer sort:integer -f 

rails db:migrate RAILS_ENV=development


sleep 1
git add -A # Add all files and commit them
git commit -m "scaffold user"


###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# already done.

  # 4. Set up the development environment to use local storage by adding a line to your development.rb file:

  # config.active_storage.service = :local  



# 5. Tell your User model that it has some attached files:


  # has_one_attached :avatar
  # has_many_attached :documents

  
###  ~~
# add new lines of text after patrn...
#
filetarg='app/models/user.rb'
cat $filetarg
r1tmp="/tmp/_temprubyrunner_${USER}.rb"
cat << 'HEREDOC' > $r1tmp
patrn='class'
  repl2 = %Q{
    has_one_attached :avatar
    has_many_attached :documents
  }
  ARGF.each do |line|
    puts line
    puts repl2 if line =~ /#{Regexp.escape(patrn)}/
  end
HEREDOC
ruby $r1tmp $filetarg > $filetarg.tmp ; cat $filetarg.tmp ; cp $filetarg.tmp $filetarg; rm $filetarg.tmp


###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# 7. Add input fields to app/views/users/_form.html.erb:

   # class="actions"


###  ~~~~
# add new lines of text before patrn...
#
filetarg='app/views/users/_form.html.erb'
cat $filetarg
r1tmp="/tmp/_temprubyrunner_${USER}.rb"
cat << 'HEREDOC' > $r1tmp
patrn='class="actions"'
  repl2 = %Q{
  <br>
  <hr>
  <div class="field">
    <%= form.label :avatar %>
    <%= form.file_field :avatar %>
  </div>

  <div class="field">
    <%= form.label :documents %>
    <%= form.file_field :documents, multiple: true %>
  </div>
  <br>
  <hr> 
  }
  ARGF.each do |line|
    puts repl2 if line =~ /#{Regexp.escape(patrn)}/
    puts line
  end
HEREDOC
ruby $r1tmp $filetarg > $filetarg.tmp ; cat $filetarg.tmp ; cp $filetarg.tmp $filetarg; rm $filetarg.tmp


###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Controller...

# if @user.save


    # avatar = params[:user][:avatar]
    # documents = params[:user][:documents]



###  

###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# add new lines of text after patrn...
#
filetarg='app/controllers/users_controller.rb'
cat $filetarg
r1tmp="/tmp/_temprubyrunner_${USER}.rb"
cat << 'HEREDOC' > $r1tmp
patrn='if @user.save'
  repl2 = %Q{
        # if avatar
        #   @user.avatar.attach(avatar)
        # end
        # if documents
        #   @user.documents.attach(documents)
        # end
        }
  ARGF.each do |line|
    puts line
    puts repl2 if line =~ /#{Regexp.escape(patrn)}/
  end
HEREDOC
ruby $r1tmp $filetarg > $filetarg.tmp ; cat $filetarg.tmp ; cp $filetarg.tmp $filetarg; rm $filetarg.tmp



# edit whitelist..
# original..      params.require(:user).permit(:name, :pdate, :active_status, :sort)
filetarg='app/controllers/users_controller.rb'
sed -i '/params.require/s/)$/, :avatar)/' $filetarg
sed -i '/params.require/s/)$/, documents: [])/' $filetarg




sleep 1
git add -A # Add all files and commit them
  git commit -m "edits"


###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# edit show...

filetarg='app/views/users/show.html.erb'
cat $filetarg
r1tmp="/tmp/_temprubyrunner_${USER}.rb"
cat << 'HEREDOC' > $r1tmp
patrn='@user.sort'
repl2 = %Q{
<hr>
<p>
  <strong>Documents:</strong>
  <ul>
   <% @user.documents.each do |document| %>
      <li><%= link_to document.blob.filename, url_for(document) %></li>
      <%# show thumbnail if it is an image.. %> 
      <%= if document.image?  then ( image_tag document.variant(resize: "100x100") )  end %> 
      

   <% end %>
  </ul>
</p>
<hr>
}
  i=-2
  ARGF.each_with_index do |line, ndx| 
    puts line
    if line =~ /#{Regexp.escape(patrn)}/
      i = ndx + 1
      #  puts ndx
      #  puts i
    end
    # puts i
    # puts ndx
    if ndx == i
        # puts i
        # puts ndx
        puts repl2 
    end 
  end
HEREDOC
ruby $r1tmp $filetarg > $filetarg.tmp ; cat $filetarg.tmp ; cp $filetarg.tmp $filetarg; rm $filetarg.tmp



# this gave an error. it may need to be updated for rails 6.

          # <%= link_to 'Remove', delete_document_attachment_user_url(document),
                    # method: :delete,
                    # data: { confirm: 'Are you sure you want to delete?' } %>




###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~











### setup bootstrap assets .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### install 1 .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### modify scaffold templates... ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  

### scaffold... ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# rails g scaffold pProduct name  pdate:datetime active_status:integer sort:integer -f \

# rails g scaffold Pfeature name fdate:datetime active_status:integer sort:integer -f \

# rails g scaffold ProductFeature name  product:references pfeature:references active_status:integer sort:integer -f \


# sleep 2
# git add -A # Add all files and commit them
# git commit -m "scaffold"



### db .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#rake db:reset
# rake db:drop


# bin/rails active_storage:install:migrations


# rake db:migrate

# bin/rails db:migrate RAILS_ENV=development
 
#rake db:seed





### populate .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




# sleep 1
# git add -A # Add all files and commit them
#   git commit -m "populate"

  

### app...js .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### controller.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### routes.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### view.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  
### application.html.erb .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  
### style the autocomplete.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### admin1 .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
### home page .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  


 
### disable turbolinks .. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 
# originally... 
  # <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  # <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
 
   
# sleep 1
# git add -A # Add all files and commit them
# git commit -m "disable turbolinks"



 
 
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
echo  run rails s -b 0.0.0.0 -p 3004
echo  then visit localhost:3000/
echo  then visit localhost:3000/products
date
#

