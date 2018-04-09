svg = d3.select 'svg'
width = svg.node().getBoundingClientRect().width
height = svg.node().getBoundingClientRect().height

num_sites = 7
radius = 2

sites_data = d3.range(num_sites).map () ->
  return {
    x: Math.round(Math.random() * (width - radius * 2) + radius),
    y: Math.round(Math.random() * (height - radius * 2) + radius)
  }

voronoi = d3.voronoi()
  .x (d) -> d.x
  .y (d) -> d.y
  .extent [[-1, -1], [width + 1, height + 1]]

cells_data = voronoi.polygons(sites_data)

# render cells
cells = svg.selectAll '.cell'
  .data cells_data

randomColor = () ->
  console.log 'asdfasdfa'
  letters = '0123456789ABCDEF'.split('')
  color = '#'
  color += letters[Math.round(Math.random() * 15)] for num in [0..5]
  color

# cells.enter().append 'path'
#   .attrs
#     class: 'cell'
#     style: 'fill: '+ randomColor()
#     d: (d) ->  if not d? then null else "M" + d.join("L") + "Z"

cells.enter().append 'path'
  .attrs
    class: 'cell'
    style: () -> 'fill: '+ randomColor()
    d: (d) ->  if not d? then null else "M" + d.join("L") + "Z"

# render sites
sites = svg.selectAll '.site'
  .data sites_data

sites.enter().append 'circle'
  .attrs
    class: 'site'
    r: radius
    cx: (d) -> d.x
    cy: (d) -> d.y
