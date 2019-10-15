
# usage: ruby add.lines.2lines.after.match.rb

def add_after_n_lines_in_memory path

  #settings..
  findline = '  <%= @user.sort %>'
  # squigly heredoc use last indent.
  newline  = <<~HEREDOC
  
      Subscription expiring soon!
      Your free trial will expire in 5 days.
      Please update your billing information.v3
      HEREDOC
      
  outpath='outfile'
  
  # the code..
  lines = File.readlines(path)
  if i = lines.index(findline.to_s+$/)
    lines.insert(i+2, newline.to_s+$/) 
    File.open(outpath, 'wb') { |file| file.write(lines.join) }
  end
end

add_after_n_lines_in_memory 'show.html.erb'
