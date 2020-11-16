document.addEventListener("DOMContentLoaded", () => {
    const map = L.map('map').setView([51.505, -0.09], 13)
    const bounds = L.latLngBounds()

    L.tileLayer( "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: "&copy; <a href='https://www.openstreetmap.org/copyright'>OpenStreetMap</a>"
    })
        .addTo(map)

    __USERS__.map(user => {
        L.marker([user.latitude, user.longitude], {
            title: user.email
        })
            .addTo(map)
            .on("click", () => [
                window.location = `/organiser/users/${user.id}`
            ])
        bounds.extend([user.latitude, user.longitude])
    })

    map.fitBounds(bounds)
})