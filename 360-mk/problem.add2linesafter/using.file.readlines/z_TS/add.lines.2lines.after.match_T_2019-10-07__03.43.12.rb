
# usage: ruby add.lines.2lines.after.match.rb

def add_after_n_lines_in_memory path

  #settings..
  findline = '@user.sort'
  # squigly heredoc use last indent.
  newline  = <<~HEREDOC
  
      Subscription expiring soon!
      Your free trial will expire in 5 days.
      Please update your billing information.v3
      HEREDOC
      
  outpath = 'outfile'
  
  # the code..
  lines = File.readlines(path)
  if lines.grep /findline/
    puts $. 
    puts "  found1 "
  end
  i = lines.index(findline)
  # puts "#{i}  found "
  if i
    lines.insert(i+2, newline.to_s+$/) 
    File.open(outpath, 'wb') { |file| file.write(lines.join) }
  end
end

add_after_n_lines_in_memory 'show.html.erb'


def greplines(filename, regex)
  lineno = 0
  File.open(filename) do |file|
    file.each_line do |line|
      puts "#{lineno += 1}: #{line}" if line =~ regex
    end
  end
end

greplines 'show.html.erb' , '/p/'


# notes

# https://www.ruby-forum.com/t/find-string-get-line-number-or-position-then-restart-at-1/174366/6

# https://stackoverflow.com/questions/11080579/how-to-print-several-lines-around-a-matched-line-in-ruby


# ruby Check if file contains string
# https://code-examples.net/en/q/804d44


# ruby file grep with index then add n lines after

# https://stackoverflow.com/questions/5761348/ruby-grep-with-line-number

# https://unix.stackexchange.com/questions/442756/python-insert-a-line-just-above-the-second-occurrence-of-a-pattern-from-end-of-f

# https://stackoverflow.com/questions/6958841/use-grep-to-report-back-only-line-numbers

