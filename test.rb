require 'io/console'

def clear_line
  STDOUT.write "\r\033[K"
end

def move_cursor_up(n)
  STDOUT.write "\033[#{n}A"
end

def writing
  STDOUT.write "\r Here is your secret pattern"
  STDOUT.write "\n"
  i = 3
  while i > 0
    STDOUT.write "\r Pattern will disappear in #{i}"
    i-=1
    sleep 1
  end
  clear_line
  move_cursor_up(1)
  clear_line
  sleep 1
  STDOUT.write "\r And another!"
  sleep 1
  STDOUT.write "\r And one more where that comes from!"
  sleep 1
  STDOUT.write "\r Take THAT!"
end

writing
