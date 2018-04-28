class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class.
  #highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #content - the string analyzed (provided)
  #line_number - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number
 

  #Add the following methods in the LineAnalyzer class. 
  #initialize() - taking a line of text (content) and a line number 
  #calculate_word_frequency() - calculates result and stores in attributes
  def initialize( content, line_number)	
    @content = content
    @line_number = line_number
    calculate_word_frequency()
  end

  #calculate the maximum number of times a single word appears within provided content and store that in the highest_wf_count attribute.
  #identify the words that were used the maximum number of times and store that in the highest_wf_words attribute.
  def self.calculate_word_frequency()
	arr = @content.gsub(/[^A-Za-z0-9\s]/i, ' ').downcase.split(" ").map { |s| s.to_s }
	countinghash = Hash.new
	for word in arr
    		if countinghash.has_key?(word)
        		countinghash[word] = countinghash[word] + 1
    		else
        		countinghash.store(word, 1)
    		end
	end

	@highest_wf_count = 0
	@highest_wf_words = ""
	countinghash.each do |key, value|
  		if @highest_wf_count < value
      			@highest_wf_count = value
      			@highest_wf_words = key
  		end
	end
	puts @highest_wf_count
	puts @highest_wf_words

  end


end
