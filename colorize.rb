class String
  #this will allow me to have colored output on the command line

  def colorize(color: 39, background: 49)
    "\e[#{color};#{background}m#{self}\e[0m"
  end

  def red
    colorize(color: 31)
  end

  def green
    colorize(color: 32)
  end

  def yellow
    colorize(color: 33)
  end

  def blue
    colorize(color: 34)
  end

  def pink
    colorize(color: 35)
  end

  def cyan
    colorize(color: 36)
  end

  def salmon
    colorize(color: 91)
  end

  def mint
    colorize(color: 92)
  end

  def lemon
    colorize(color: 93)
  end

  def azure
    colorize(color: 94)
  end

  def flamingo
    colorize(color: 95)
  end

  def sky
    colorize(color: 96)
  end

  def red_background
    colorize(background: 41)
  end

  def green_background
    colorize(background: 42)
  end

  def yellow_background
    colorize(background: 43)
  end

  def blue_background
    colorize(background: 44)
  end

  def magenta_background
    colorize(background: 45)
  end

  def cyan_background
    colorize(background: 46)
  end

end
