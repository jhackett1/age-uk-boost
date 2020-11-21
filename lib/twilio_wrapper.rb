require 'twilio-ruby'

module TwilioWrapper

    def send_sms(to)
        client.messages.create(
            from: ENV["TWILIO_FROM_NUMBER"] || "+14235464722",
            to: to,
            body: "Example SMS message — http://foo.com"
        )
    end

    private

    def client
        Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_AUTH_TOKEN"])
    end

end