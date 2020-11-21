const createMap = container => {

    const bounds = L.latLngBounds()
    const map = L.map(container)

    L.tileLayer( "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: "&copy; <a href='https://www.openstreetmap.org/copyright'>OpenStreetMap</a>"
    })
        .addTo(map)

    Array.prototype.concat(__MARKERS__).map(task => {
        L.marker([task.latitude, task.longitude], {
            title: task.name
        })
            .addTo(map)
            .on("click", () => window.location = `/tasks/${task.id}`)
            
        bounds.extend([task.latitude, task.longitude])
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