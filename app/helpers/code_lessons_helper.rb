module CodeLessonsHelper

  def evaluate_code(code, language, stdin = nil)
    data = {
      clientId: ENV['CLIENT_ID'],
      clientSecret: ENV['CLIENT_SECRET'],
      script: code,
      stdin: stdin,
      language: language.code_eval_slug,
      versionIndex: language.code_eval_version
    }

    url = URI.parse('https://api.jdoodle.com/v1/execute')
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Post.new(url.to_s, { 'Content-Type': 'application/json' })
    req.body = data.to_json
    res = https.request(req)

    return JSON.parse(res.body)
  end

  def format_code_output(output)
    output.split("\n")
  end

  def correctness_code(language, correctness_test, output)
    test_string = ''
    case language.name
    when 'Ruby'
      test_string = <<~RUBY_STRING
      def test_function
        #{correctness_test}
      end

      puts test_function
      RUBY_STRING
    end

    test_string
  end
end
