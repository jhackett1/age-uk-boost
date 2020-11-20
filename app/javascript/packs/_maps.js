const createMap = container => {

    const bounds = L.latLngBounds()
    const map = L.map(container)

    L.tileLayer( "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: "&copy; <a href='https://www.openstreetmap.org/copyright'>OpenStreetMap</a>"
    })
        .addTo(map)

    Array.prototype.concat(__MARKERS__).map(user => {
        L.marker([user.latitude, user.longitude], {
            title: user.email
        })
            .addTo(map)
            .on("click", () => window.location = `/organiser/users/${user.id}`)
            
        bounds.extend([user.latitude, user.longitude])
    })

    map.fitBounds(bounds)

    window.handleMapToggle = () => { 
        if(map){
            map.invalidateSize()         
            map.fitBounds(bounds)
        }
    }
}

document.querySelectorAll("#map-canvas").forEach(container => {
    createMap(container)
})