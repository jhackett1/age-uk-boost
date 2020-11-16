Order.delete_all
User.delete_all
Role.delete_all
Service.delete_all

Role.create([
    { name: "volunteer" },
    { name: "organiser" },
    { name: "client" }
])

User.create({
    email: "jaye.hackett@gmail.com",
    password: "password",
    first_name: "Jaye",
    last_name: "Hackett",
    role: Role.find_by({ name: "organiser" }),
    address: "459 Bordesley Green East",
    postcode: "B33 8PP",
    phone: "0777 777 7777"
})

Service.create([
    { name: "food delivery" },
    { name: "check in" }
])