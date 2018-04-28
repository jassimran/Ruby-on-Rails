class Solution
attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
 
  def initialize( content, line_number)	
    @analyzers = []
  end


  #Read the ‘test.txt’ file in lines
  #Create an array of LineAnalyzers for each line in the file
  def self.analyze_file() 
	LineAnalyzers = IO.readlines("test.txt")
  end

  #calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in the analyzers array 
  #and store this result in the highest_count_across_lines attribute.
  #identify the LineAnalyzer object(s) in the analyzers array that have the highest_wf_count equal to
  #the highest_count_across_lines attribute value found in the previous step and store them in high-est_count_words_across_lines attribute.
  def self.calculate_line_with_highest_frequency() 

  end

  def self.print_highest_word_frequency_across_lines() 
    puts "The following words have the highest word frequency per line: /n ["word1"] (appears in line #)["word2", "word3"] (appears in line #)"
  end
end

