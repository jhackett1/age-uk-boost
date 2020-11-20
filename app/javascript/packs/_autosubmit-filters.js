let allFilters = document.querySelectorAll("#filterrific_filter")

allFilters.forEach(filter => {
    filter.addEventListener("change", () => {
        filter.submit()
    })
})