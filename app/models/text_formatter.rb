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

















# line.enum_for(:scan,/ /).map { Regexp.last_match.begin(0) }

# def self.format_text(text, wrap=50, indent=2)
#   result = []
#   work = text.dup
#   while work.length > wrap do
#     # binding.pry
#     if work =~ %r(^(.{0,#{wrap}})[ \n]) then
#       result << $1.rstrip
#       work.slice!(0, $&.length)
#     else
#       result << work.slice!(0, wrap)
#     end
#   end
#   result << work if work.length.nonzero?
#   puts result.join("\n").gsub(/^/, " " * indent)
#   result.join("\n").gsub(/^/, " " * indent)
# end



# def self.arrange_line(line,max_length)
#   line_length = line.length
#   remaining_length = max_length-line_length
#   if remaining_length > 0
#     while true
#       break if line.length >= 50
#       arr = compute_index(line)
#       arr_line = line.dup
#       arr.each_with_index do |index,key|
#         # binding.pry
#         break if line.length >= 50
#         line.insert(index,key.to_s) if line.length < 50
#       end
#     end
#   end
#   return line
# end
