
rails active storage

# rails new rac360c --dev --force
# [!] There was an error while loading `thread_safe.gemspec`: uninitialized constant ThreadSafe
# Did you mean?  Threadsafe. Bundler cannot continue.


on pdata4 sftp://albe@10.4.1.227/srv/share/_mksh/rac360d


follow this, exceptions below..

  https://afreshcup.com/home/2017/07/23/activestorage-samples


rails new rac360d


bundle


bundle exec rails g scaffold user name:string
  bundle exec rails db:create
  bundle exec rails db:migrate
  bundle exec rails s
  

# no  
# bundle exec rails activestorage:install

bin/rails active_storage:install
  
rake db:migrate


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



7. Add input fields to app/views/users/_form.html.erb:

   class="actions"


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


Controller...

if @user.save


    avatar = params[:user][:avatar]
    documents = params[:user][:documents]



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




# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
