require 'twilio-ruby'

module TwilioClient

    def send_sms(to, body)
        if Rails.env.production?
            client.messages.create(
                from: ENV["TWILIO_FROM_NUMBER"] || "+14235464722",
                to: to,
                body: body
            )
        else
            print "\n\n------\n\n"
            print "TO: #{to}";
            print "MESSAGE: #{message}";
            print "\n\n------\n\n"
        end
    end

    private

    def client
        Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_AUTH_TOKEN"])
    end

end