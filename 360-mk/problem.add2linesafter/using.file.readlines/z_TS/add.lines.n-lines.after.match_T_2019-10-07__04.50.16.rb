
# ruby.grep.then.insert.relative.to.matching.linenumbers.rb


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



def greplines(filename,patrn)

  linearr = []
  File.open(filename) do |file|
    lcount = 0
    lineno = 0
    file.each_line do |line|
      lineno += 1
      if line =~ /#{Regexp.escape(patrn)}/
        puts "#{lineno}, #{lcount +=1 }: #{line} " 
        linearr.insert(-1,lineno)
      end  
    end
    print 'linearr..'
    puts linearr.inspect
  end
  
  return linearr[0]
end


linetoact = 0
linetoact = greplines 'show.html.erb' , '@user'
puts linetoact
add_after_n_lines_in_memory 'show.html.erb'


# notes

# https://www.ruby-forum.com/t/find-string-get-line-number-or-position-then-restart-at-1/174366/6

# https://stackoverflow.com/questions/11080579/how-to-print-several-lines-around-a-matched-line-in-ruby


# ruby Check if file contains string
# https://code-examples.net/en/q/804d44


# ruby file grep with index then add n lines after

# https://stackoverflow.com/questions/5761348/ruby-grep-with-line-number

# https://unix.stackexchange.com/questions/442756/python-insert-a-line-just-above-the-second-occurrence-of-a-pattern-from-end-of-f

# https://stackoverflow.com/questions/6958841/use-grep-to-report-back-only-line-numbers


# array first ..Usually done by using the index 0
# 2.0.0-p0 :010 > letters[0] => "a"
# Accessing the last element. 2.0.0-p0 :011 > letters[-1]


# see..  .rb \n\ grep

