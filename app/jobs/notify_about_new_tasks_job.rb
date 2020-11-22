class NotifyAboutNewTasksJob < ApplicationJob
  queue_as :default

  include TwilioClient

  def perform(*args)

    new_tasks = Task.where('created_at >= ?', 1.day.ago).count

    if new_tasks
        message = "New tasks are available to claim. Find them at #{ENV["HOST"]}"
        users = User.where(notify_about_new_tasks: true)

        users.each do |u|
          print message
          send_sms(u.phone, message)
        end
    end


  end
end
