class Linebreak

  SAMPLE_TEXT = "In 1991, while studying computer science at University of Helsinki, Linus Torvalds began a project that later became the Linux kernel. He wrote the program specifically for the hardware he was using and independent of an operating system because he wanted to use the functions of his new PC with an 80386 processor. Development was done on MINIX using the GNU C Compiler."

  def initialize(args)
    @raw_data   = args
    @text       = args[0] || SAMPLE_TEXT
    @char_limit = (args[1] || 40).to_i
 
    @complete_lines = break_lines
    print_lines
  end

  def text
    @text
  end

  def complete_lines
    @complete_lines
  end

  def char_limit
    @char_limit
  end

  private

  def break_lines
    raise "char limit can't be smaller than the biggest word on the provided text" if validate_char_limit_and_word_size

    sample_array = @text.split(' ')

    array_complete_lines = []
    full_line = ''
    while sample_array.length > 0
      if full_line.length + sample_array[0].length <= @char_limit
        full_line += sample_array.shift
        full_line += ' '
        
        if sample_array.length == 0
          array_complete_lines << full_line.strip # The last iteration of the loop
        end
      else
        array_complete_lines << full_line
        full_line = ''
      end
    end

    return array_complete_lines.join("\n")
  end

  def print_lines
    puts @complete_lines
  end

  def validate_char_limit_and_word_size
    max = @text.split(' ').max_by(&:length).length

    return true if max > @char_limit
  end

  if $PROGRAM_NAME == __FILE__
    Linebreak.new(ARGV)
  end
end