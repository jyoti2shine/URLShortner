class TextFormatter
  def self.format_ruby_text(text,wrap,format=true)
    output = []
    new_text = text
    while new_text.length > wrap
      wrapped_text = new_text[0..wrap]
      if wrapped_text.include?("\n")
        scrapped = fetch_original_text(wrapped_text.split("\n"),"\n")
      elsif wrapped_text[-1] != " "
        scrapped = fetch_original_text(wrapped_text.split()," ")
      else
        scrapped = wrapped_text
      end
      output << scrapped.strip
      new_text.slice!(0,scrapped.length)
      new_text.strip!
    end
    output << new_text unless new_text.length.zero?
    return output.join("\n") unless format
    return output.map{ |line| arrange_line(line,wrap)}.join("\n")
  end

  def self.fetch_original_text(text,limiter)
    return text[0...-1].join(limiter)
  end

  def self.arrange_line(line,max_length)
    line_length = line.length
    remaining_length = max_length-line_length
    if remaining_length > 0
      space_count = compute_flag(line,nil)
      count = 0
      while true
        break if line.length >= max_length || compute_flag(line,count).nil?
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

  def self.compute_flag(line,flag=0)
    indexes = line.enum_for(:scan,/ /).map { Regexp.last_match.begin(0) }
    return indexes.count if flag.nil?
    new_indexes = []
    while !indexes.empty?
      new_indexes << indexes.delete(indexes[0])
      new_indexes << indexes.delete(indexes[-1])
    end
    new_indexes.compact[flag]
  end
end