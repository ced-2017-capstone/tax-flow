import d3 from 'd3'

// Define the dimensions of the visualization. We're using
// a size that's convenient for displaying the graphic on
// http://jsDataV.is

var width = 640,
  height = 480

// Define the data for the example. In general, a force layout
// requires two data arrays. The first array, here named `nodes`,
// contains the object that are the focal point of the visualization.
// The second array, called `links` below, identifies all the links
// between the nodes. (The more mathematical term is "edges.")

// For the simplest possible example we only define two nodes. As
// far as D3 is concerned, nodes are arbitrary objects. Normally the
// objects wouldn't be initialized with `x` and `y` properties like
// we're doing below. When those properties are present, they tell
// D3 where to place the nodes before the force layout starts its
// magic. More typically, they're left out of the nodes and D3 picks
// random locations for each node. We're defining them here so we can
// get a consistent application of the layout which lets us see the
// effects of different properties.

var nodes = [{
  x: width / 3,
  y: height / 2
},
{
  x: 2 * width / 3,
  y: height / 2
}
]

// The `links` array contains objects with a `source` and a `target`
// property. The values of those properties are the indices in
// the `nodes` array of the two endpoints of the link.

var links = [{
  source: 0,
  target: 1
}]

// Here's were the code begins. We start off by creating an SVG
// container to hold the visualization. We only need to specify
// the dimensions for this container.

var svg = d3.select('body').append('svg')
    .attr('width', width)
    .attr('height', height)

var force = d3.layout.force()
    .size([width, height])
    .nodes(nodes)
    .links(links)

force.linkDistance(width / 2)

var link = svg.selectAll('.link')
    .data(links)
    .enter().append('line')
    .attr('class', 'link')

var node = svg.selectAll('.node')
    .data(nodes)
    .enter().append('circle')
    .attr('class', 'node')

force.on('end', function () {
  node.attr('r', width / 25)
        .attr('cx', function (d) {
          return d.x
        })
        .attr('cy', function (d) {
          return d.y
        })

  link.attr('x1', function (d) {
    return d.source.x
  })
        .attr('y1', function (d) {
          return d.source.y
        })
        .attr('x2', function (d) {
          return d.target.x
        })
        .attr('y2', function (d) {
          return d.target.y
        })
})

force.start()
