
# usage: ruby add.lines.2lines.after.match.rb

def add_after_n_lines_in_memory path
  findline = '  <%= @user.sort %>'
  newline  = '----------added line'
  lines = File.readlines(path)
  if i = lines.index(findline.to_s+$/)
    lines.insert(i+2, newline.to_s+$/) 
    File.open(path, 'wb') { |file| file.write(lines.join) }
  end
end

add_after_n_lines_in_memory 'show.html.erb'
