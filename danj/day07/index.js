const helpers = require('../helpers').default

const treesUpdateWeights = trees => {
  return trees.map(t => {
    let combinedWeight = t.weight || 0

    let newChildren = treesUpdateWeights(t.children)

    combinedWeight += (newChildren.reduce((acc, c) => acc + c.combinedWeight, 0))

    return Object.assign(t, { combinedWeight })
  })
}

const sortTrees = trees => trees.sort((a,b) => b.combinedWeight - a.combinedWeight)

const replaceNodeInTrees = (node, trees) => {
  if(trees.length === 0) return [[], false]

  let replaced = false
  const newTrees = trees.map((tree, treeIdx) => {
    if (tree.name === node.name) {
      replaced = true
      return node
    } else {
      // check if the children can replace the node
      const [resTrees, resReplaced] = replaceNodeInTrees(node, tree.children)
      if (resReplaced) replaced = true
      return Object.assign(tree, { children: resTrees })
    }
  })
  return [newTrees, replaced]
}

const buildTreesFromData = data => {
  let trees = []
  let nodes = {}

  data.map((d, idx) => {
    const split = d.split(' ')

    const name = split[0]
    const weight = Number(split[1].slice(1, -1)) || 0

    // create the base
    let row = {
      name,
      weight,
      combinedWeight: 0,
      children: []
    }

    if (split.length !== 2) {
      row.children = split.splice(3).join('').split(',').map(c => ({ name: c, children: [], weight: 0, combinedWeight: 0}))
    }

    trees.push(row)
  })

  let length = trees.length
  while(length-- > 0) {
    const node = trees.splice(0,1)[0]
    const res = replaceNodeInTrees(node, trees)

    if (res[1] === false) trees.push(node)
  }

  return sortTrees(treesUpdateWeights(trees))
}

const findUnbalancedChildren = tree => {
  let weightCounts = {}
  let keys = []

  let counts = new Set()

  tree.children.map((n,id) => {
    if(!weightCounts[n.combinedWeight]) weightCounts[n.combinedWeight] = { id, count: 1 }
    else weightCounts[n.combinedWeight].count++
  })

  if (Object.keys(weightCounts).length === 1) return []

  const sortedKeys = Object.keys(weightCounts).sort((a,b) => weightCounts[a].count - weightCounts[b].count)
  const node = tree.children[weightCounts[sortedKeys[0]].id]

  const unbalanced = findUnbalancedChildren(node)
  if (unbalanced.length === 0) {
    // it's this set of nodes that is different [we could be inside a call to this function inside a call... inception]
    const otherCombinedWeight = tree.children[weightCounts[sortedKeys[1]].id].combinedWeight
    return node.weight - (node.combinedWeight - otherCombinedWeight)
  }
  return unbalanced
}

const partA = input => {
  const sortedTrees = buildTreesFromData(helpers.splitByNewLine(input))
  return sortedTrees[0].name
}

const partB = input => {
  const sortedTrees = buildTreesFromData(helpers.splitByNewLine(input))
  const unbalancedChildrenCount = findUnbalancedChildren(sortedTrees[0])
  return unbalancedChildrenCount
}

export default {
  a: partA,
  b: partB
}