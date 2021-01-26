require 'json'
require 'net/http'

while true
  print 'Enter kahoot challenge ID: '
  challenge_id = gets.chomp
  
  uri = URI("https://kahoot.it/rest/challenges/#{challenge_id}/answers")
  response = ''
  Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new uri
    response = http.request request # Net::HTTPResponse object
  end

  answers = JSON.parse(response.body)

  answers['answers'].each_with_index do |question, i|
    puts "Question #{i + 1}: #{question['question']['title']}"
    final_answer = ''
    question['question']['choices'].each do |answer|
      if answer['correct']
        final_answer = answer['answer']
        break
      end
    end
    puts "Answer: #{final_answer}"
    puts ''
  end
end
