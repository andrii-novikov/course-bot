class SubscribeSchedule
  attr_reader :scheduler, :bot, :jobs

  def initialize
    @scheduler = Rufus::Scheduler.new
    @bot = Telegram::Bot::Api.new(ENV['TOKEN'])
    @jobs = {}
  end

  def add(chat_id, time)
     job_id = scheduler.every time do
                bot.send_message(chat_id: chat_id, text: CourseBot.get_courses)
              end
     @jobs[chat_id] = job_by_id(job_id)
  end

  def remove(id)
    @jobs[id].unschedule
    @jobs.delete(id)
  end

  def job_by_id(id)
    scheduler.jobs.find { |j| j.id == id}
  end
end