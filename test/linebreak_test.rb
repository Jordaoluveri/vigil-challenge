require "minitest/autorun"
require_relative "../linebreak"


class TestLinebreak < Minitest::Test
  def test_output_equals_to_input
    linebreak = Linebreak.new([])

    assert_equal linebreak.text, linebreak.complete_lines.delete("\n")
  end

  def test_char_limit_cant_be_smaller_than_biggest_word
    assert_raises RuntimeError do
      Linebreak.new(['Lorem Ipsum', '1'])
    end
  end

  def test_no_line_is_bigger_than_char_limit
    linebreak = Linebreak.new([])

    linebreak.complete_lines.split("\n").each do |line|
      assert line.strip.length <= linebreak.char_limit
    end
  end
end