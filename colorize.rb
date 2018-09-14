class String
  #this will allow me to have colored output on the command line
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def cyan
    colorize(36)
  end

  def salmon
    colorize(91)
  end

  def mint
    colorize(92)
  end

  def lemon
    colorize(93)
  end

  def azure
    colorize(94)
  end

  def flamingo
    colorize(95)
  end

  def sky
    colorize(96)
  end

end
