class CourseBot
	CURRENCY = { 
	  dollar: %w[dollar usd], 
	  euro: %w[euro eur],
	  rub: %w[rub rur]
	}

	def self.get_course_json
	  symbolize_keys JSON.parse(HTTP.get(ENV['COURSE_URL']))
	end

	def self.get_courses
	  get_course_json.map { |currency, course| format_course(currency, symbolize_keys(course)) }.join("\n")
	end

	def self.get_course(currency = :dollar)
	  course = symbolize_keys get_course_json[currency]
	  format_course(currency, course)
	end

	def self.symbolize_keys(hash)
		hash = hash.map { |k,v| [k.downcase.to_sym,v] }.to_h
	end

	def self.format_course(currency, course)
	  "#{currency.to_s.capitalize}: sale - #{course[:sale]}, buy - #{course[:buy]}"
	end

	def self.find_currency(text)
	  CURRENCY.find { |k, v| v.include?(text) }&.first
	end
end
