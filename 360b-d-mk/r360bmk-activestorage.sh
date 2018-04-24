
rails active storage

# rails new rac360c --dev --force
# [!] There was an error while loading `thread_safe.gemspec`: uninitialized constant ThreadSafe
# Did you mean?  Threadsafe. Bundler cannot continue.


on pdata4 sftp://albe@10.4.1.227/srv/share/_mksh/rac360d


follow this, with  exceptions below..

  https://afreshcup.com/home/2017/07/23/activestorage-samples
  https://github.com/ffmike/activestorage_sample
  

  
      ref. 
      
      https://www.engineyard.com/blog/active-storage
            
            https://gorails.com/episodes/file-uploading-with-activestorage-rails-5-2
              <% if upload.variable? %>

              
      https://stackoverflow.com/questions/49515529/rails-5-2-active-storage-purging-deleting-attachements

      
###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

rails new rac360d


bundle

###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


bundle exec rails g scaffold user name:string
  bundle exec rails db:create
  bundle exec rails db:migrate
  bundle exec rails s
  

# no  
# bundle exec rails activestorage:install

bin/rails active_storage:install
  
rake db:migrate

###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


already done.

  4. Set up the development environment to use local storage by adding a line to your development.rb file:

  config.active_storage.service = :local  



5. Tell your User model that it has some attached files:


  has_one_attached :avatar
  has_many_attached :documents

  
###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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



7. Add input fields to app/views/users/_form.html.erb:

   class="actions"


###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# add new lines of text before patrn...
#
filetarg='app/views/users/_form.html.erb'
cat $filetarg
r1tmp="/tmp/_temprubyrunner_${USER}.rb"
cat << 'HEREDOC' > $r1tmp
patrn='class="actions"'
  repl2 = %Q{
  <div class="field">
    <%= form.label :avatar %>
    <%= form.file_field :avatar %>
  </div>

  <div class="field">
    <%= form.label :documents %>
    <%= form.file_field :documents, multiple: true %>
  </div>
  }
  ARGF.each do |line|
    puts repl2 if line =~ /#{Regexp.escape(patrn)}/
    puts line
  end
HEREDOC
ruby $r1tmp $filetarg > $filetarg.tmp ; cat $filetarg.tmp ; cp $filetarg.tmp $filetarg; rm $filetarg.tmp


###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Controller...

if @user.save


    avatar = params[:user][:avatar]
    documents = params[:user][:documents]



###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# add new lines of text after patrn...
#
filetarg='app/controllers/users_controller.rb'
cat $filetarg
r1tmp="/tmp/_temprubyrunner_${USER}.rb"
cat << 'HEREDOC' > $r1tmp
patrn='if @user.save'
  repl2 = %Q{
        if avatar
          @user.avatar.attach(avatar)
        end
        if documents
          @user.documents.attach(documents)
        end
        }
  ARGF.each do |line|
    puts line
    puts repl2 if line =~ /#{Regexp.escape(patrn)}/
  end
HEREDOC
ruby $r1tmp $filetarg > $filetarg.tmp ; cat $filetarg.tmp ; cp $filetarg.tmp $filetarg; rm $filetarg.tmp


###  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

show.html.erb

no works..

   <% if @user.avatar %>
      <li><%= ( image_tag(url_for(@user.avatar))  ) unless @user.avatar.nil %></li>
   <% end %>
 

<p>
  <%#= Can't resolve image into URL: to_model delegated to attachment, but attachment is nil %>
  <%= image_tag @user.avatar %>
<p>


 

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

works for documents..

<p>
  <strong>Documents:</strong>
  <ul>
    <% @user.documents.each do |document| %>
      <li><%= link_to document.blob.filename, url_for(document) %></li>
    <% end %>
  </ul>
<p>


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

kinda works..

<p>
  <strong>Documents:</strong>
  <ul>
    <% @user.documents&.each do |document| %>
      <li><%=  image_tag(document) %></li>
    <% end %>
  </ul>
<p>



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

http://edgeguides.rubyonrails.org/active_storage_overview.html


gem 'mini_magick'

When the browser hits the variant URL, Active Storage will lazy transform the original blob into the format you specified and redirect to its new service location.

<%= image_tag user.avatar.variant(resize: "150x150") %>



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

https://evilmartians.com/chronicles/rails-5-2-active-storage-and-beyond


<% if @post.images.attached? %>
<p>
  <strong>Images:</strong>
  <br>
  <% @post.images.each do |image| %>
    <%= image_tag(image) %>
  <% end %>
</p>
<% end %>


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Installation

On your gemfile: gem 'rails_admin', '~> 1.3'


Run bundle install
Run rails g rails_admin:install
Provide a namespace for the routes when asked
Start a server rails s and administer your data at /radmin. (if you chose default namespace: /radmin)


rails active_storage:install
rails db:migrate


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

added delele feature..


commit 0efcf83a751ee6dd7eebbbb5506c9e8ee35195ff
Author: David Gleba <dgleba@gmail.com>
Date:   Thu Apr 19 20:47:37 2018 -0400

    add delete feature 2018-04-19

diff --git a/app/controllers/users_controller.rb b/app/controllers/users_controller.rb

+++ b/app/controllers/users_controller.rb
@@ -83,7 +83,18 @@ class UsersController < ApplicationController
       format.json { head :no_content }
     end
   end
+  
+  
+  
+  def delete_document_attachment
+      @document = ActiveStorage::Attachment.find(params[:id])
+      @document.purge
+      # redirect_to @current_page
+      redirect_back(fallback_location: root_path)     
+  end
+  

diff --git a/app/views/users/show.html.erb b/app/views/users/show.html.erb

+++ b/app/views/users/show.html.erb
@@ -13,6 +13,11 @@
       <li><%= link_to document.blob.filename, url_for(document) %></li>
       <%# show thumbnail if it is an image.. %> 
       <%= if document.image?  then ( image_tag document.variant(resize: "100x100") )  end %> 
+      
+          <%= link_to 'Remove', delete_document_attachment_user_url(document),
+                    method: :delete,
+                    data: { confirm: 'Are you sure you want to delete?' } %>
+      

diff --git a/config/routes.rb b/config/routes.rb

@@ -1,5 +1,13 @@
 Rails.application.routes.draw do
   mount RailsAdmin::Engine => '/radmin', as: 'rails_admin'
-  resources :users
+
+  resources :users do
+    member do
+      delete :delete_document_attachment
+    end
+  end  
+  
+  root 'user#index'
+  




# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



https://afreshcup.com/home/2017/07/23/activestorage-samples



A New Edge Rails Application
Start by spinning up a simple application with edge rails:

1. Create a new directory and use whatever you like (rvm, rbenv, chruby) to give it a fresh Ruby environment. I used Ruby 2.4.1 in my testing.

2. Install bundler:

  gem install bundler
3. Create a simple Gemfile in your new directory:

  source 'https://rubygems.org'
  gem 'rails', git: 'https://github.com/rails/rails.git'
4. Install Rails and everything it drags in:

  bundle install
5. Create a new Rails application in the current directory, using the version of Rails you just installed and overwriting the Gemfile:

  bundle exec rails new . --dev --force
6. Create and start the simplest possible application:

  bundle exec rails g scaffold user name:string
  bundle exec rails db:create
  bundle exec rails db:migrate
  bundle exec rails s
You should now be able to go to http://localhost:3000/users to create and update users. Yay!

Active Storage with Local File Storage

Let's start by making sure that Active Storage is working without getting the cloud involved:

1. Create a new branch of code:

  git checkout -b local
2. Install Active Storage to your application:

bundle exec rails activestorage:install
This will create the storage and tmp/storage directories in your application, copy a default configuration file to config/storage.yml, and create a new migration. The migration builds the active_storage_blobs and active_storage_attachments tables in your database.

3. Update the database schema:

bundle exec rails db:migrate
4. Set up the development environment to use local storage by adding a line to your development.rb file:

config.active_storage.service = :local
5. Tell your User model that it has some attached files:

class User < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :documents
  ...
end
6. Comment out the amazon, google, microsoft, and mirror sections from the config/storage.yml file. Otherwise, your server won't start, because it will be looking for keys and files that don't exist.

7. Add input fields to app/views/users/_form.html.erb:

  <div class="field">
    <%= form.label :avatar %>
    <%= form.file_field :avatar %>
  </div>

  <div class="field">
    <%= form.label :documents %>
    <%= form.file_field :documents, multiple: true %>
  </div>
8. Add controls to app/views/users/show.html.erb to display the data

<p>
  <%= image_tag(url_for(@user.avatar)) %>
<p>

<p>
  <strong>Documents:</strong>
  <ul>
    <% @user.documents.each do |document| %>
      <li><%= link_to document.blob.filename, url_for(document) %></li>
    <% end %>
  </ul>
<p>
9. Update your users controller to attach the files:

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    avatar = params[:user][:avatar]
    documents = params[:user][:documents]

    respond_to do |format|
      if @user.save
        if avatar
          @user.avatar.attach(avatar)
        end
        if documents
          @user.documents.attach(documents)
        end
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    avatar = params[:user][:avatar]
    documents = params[:user][:documents]

    respond_to do |format|
      if @user.update(user_params)
        if avatar
          @user.avatar.attach(avatar)
        end
        if documents
          @user.documents.attach(documents)
        end
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
10. Restart your application. You should now be able to add avatars and documents to users, and retrieve them via the show view.



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
