User.delete_all
Role.delete_all
Service.delete_all

Role.create([
    { name: "volunteer" },
    { name: "organiser" }
])

User.create({
    email: "jaye.hackett@gmail.com",
    password: "password",
    first_name: "Jaye",
    last_name: "Hackett",
    role: Role.find_by({ name: "organiser" })
})

Service.create([
    { name: "food delivery" },
    { name: "check in" }
])