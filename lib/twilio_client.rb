require 'twilio-ruby'

module TwilioClient

    def send_sms(to, body)
        client.messages.create(
            from: ENV["TWILIO_FROM_NUMBER"] || "+14235464722",
            to: to,
            body: body
        )
    end

    private

    def client
        Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_AUTH_TOKEN"])
    end

end