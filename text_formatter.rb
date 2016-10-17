# == Text Formatter
#
# Provides a modified +format_ruby_text+ that you use in your Program
# for Generating Formatted/Non Formatted Text using a defined Text Length.
#
# A minimal implementation could be:
#
#   class Text
#
#     def initialize
#       @text = String.new("Example Text .......")
#     end
#
#  The following method is used for Formatted Text
#
#     def format_my_text
#       return TextFormatter.format_ruby_text(@text,50,true)
#     end
#
#  The Following Method is Used for Non Formatted Text
#
#     def unformatted_text
#       return TextFormatter.format_ruby_text(@text,50,false)
#     end
#   end

class TextFormatter
  def self.format_ruby_text(text,wrap,format=true)
    output = []  # Stores The Output.
    new_text = text.dup # Dups the Text Object to New Text So that the original text is retained.
    while new_text.length > wrap
      wrapped_text = new_text[0..wrap]
       # Check for a New Line
      if wrapped_text.include?("\n") 
        scrapped = fetch_original_text(wrapped_text.split("\n"),"\n")
      # Check for a Broken Line
      elsif wrapped_text[-1] != " " 
        scrapped = fetch_original_text(wrapped_text.split()," ")
      else
        scrapped = wrapped_text
      end
      output << scrapped.strip
      # Remove the Scrapped Text from The Original Text
      new_text.slice!(0,scrapped.length)
      new_text.strip!
    end
    # Push the remaining line into the o/p array as it is less than Wrap Size
    output << new_text unless new_text.length.zero?
    return output.join("\n") unless format
    return output.map{ |line| arrange_line(line,wrap)}.join("\n")
  end

  # Return the Specific Text based on limiter and remove the Last part from the text Array
  def self.fetch_original_text(text,limiter)
    return text[0...-1].join(limiter)
  end
  
  # Check for Remaining length and Add Spaces e.x [3,4,5,6] Fill spaces in Index [3,6,4,5]
  def self.arrange_line(line,max_length)
    line_length = line.length
    remaining_length = max_length-line_length
    if remaining_length > 0
      space_count = compute_flag(line,nil)
      count = 0 # Count to check The Space Index 
      while true
        break if line.length >= max_length || compute_flag(line,count).nil?
        # Insert a Text or Caharcter into the Line
        line.insert(compute_flag(line,count),"-")
        if count < space_count-1
          count += 1
        else
          count = 0
        end
      end
    end
    return line.gsub("-"," ")
  end

  # Compute Flag Returns the Index Position of Blank Space where an Extra Character(" ") needs to be filled .
  def self.compute_flag(line,flag=0)
    # Scans the line/text based on Space(" ")
    indexes = line.enum_for(:scan,/ /).map { Regexp.last_match.begin(0) }
    return indexes.count if flag.nil?
    new_indexes = []
    # Delete the First and Last Element from array to Fill the space in First - Last Format [e.x [3,4,5,6] Fill spaces in Index [3,6,4,5]]
    while !indexes.empty?
      new_indexes << indexes.delete(indexes[0])
      new_indexes << indexes.delete(indexes[-1])
    end
    new_indexes.compact[flag]
  end
end
