subscribe = Subscribe.new
subscribe_schedule = SubscribeSchedule.new

subscribe.subscribers.each do |id, time|
  subscribe_schedule.add(id, time)
end

Telegram::Bot::Client.run(ENV['TOKEN'], logger: Logger.new(ENV['LOG'])) do |bot|
  bot.listen do |message|
    answer = case message.text
             when '/start'
               "Hello, #{message.from.first_name}"
             when '/stop'
               "Bye, #{message.from.first_name}"
             when '/subscribe'
               if subscribe.add(message.chat.id)
                 "You subscribed success"
               else
                 "You are already subscribed"
               end
             when '/unsubscribe'
               if subscribe.remove(message.chat.id)
                 "You successfuly unsubscribed"
               else
                 "You didn't have subscribe"
               end
          	 else
          	   currency = CourseBot.find_currency(message.text.delete('/'))
          	   currency ? CourseBot.get_course(currency) : CourseBot.get_courses
             end

    bot.api.send_message(chat_id: message.chat.id, text: answer)
  end
end

# subscribe - Subscribe for daily notifications
# unsubscribe - Unsubscribe for daily notifications
# usd - Show USD course
# rub - Show RUB course
# eur - Show EUR course