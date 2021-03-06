require 'faker'

Task.delete_all
User.delete_all

User.create({
    first_name: "Admin",
    last_name: "User",
    phone: ENV["ADMIN_PHONE"],
    address: "BBC Broadcasting House, Portland Place, London",
    postcode: "W1A 1AA",
    admin: true
})

Faker::Config.locale = 'en-GB'

postcodes = [
    "SE25 4DP",
    "W12 0PB",
    "E3 2DL",
    "W10 5DB",
    "SW12 8LL",
    "E6 3QS",
    "SE2 9PN",
    "SW3 4LQ",
    "NW3 2EA",
    "N2 9QE"
]

10.times do
    Task.create({
        name: Faker::Name.name,
        special_request: Faker::Lorem.paragraph(sentence_count: 3),
        address: Faker::Address.street_address,
        postcode: postcodes.sample,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number,
        urgent: Faker::Boolean.boolean(true_ratio: 0.2)
    })
end