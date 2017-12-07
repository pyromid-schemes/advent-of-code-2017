import { print } from 'util';

const helpers = require('../helpers').default

const printTrees = trees => {
  console.log(`PRINTING TREES`) 
  trees.map((d,idx) => {
    console.log(`PRITING TREE [${idx}]`)
    printTree(d)
  })
  console.log()
}

const printTree = (tree, n = 1) => {
  let lines = ' '
  let temp = n
  while(temp-- > 0) lines += '-'
  console.log(`${lines} ${tree.name} ow[${tree.weight}] treeWeight[${tree.combinedWeight}]`)

  if(tree.children){ 
    tree.children.map(c => printTree(c, n + 1))
  }
}

const treesUpdateWeights = trees => {
  return trees.map(t => {
    let combinedWeight = t.weight || 0

    let newChildren = treesUpdateWeights(t.children)
    // console.log('newChildren', newChildren.combinedWeight)

    combinedWeight += (newChildren.reduce((acc, c) => acc + c.combinedWeight, 0))

    return Object.assign(t, { combinedWeight })
  })
}

const sortTrees = trees => trees.sort((a,b) => b.combinedWeight - a.combinedWeight)

// const replaceNodeInTree = (node, tree) => {
//   tree = { name: 'xyz', children: [ARRAY OF TREES] } 
// }

const replaceNodeInTrees = (node, trees) => {
  if(trees.length === 0) return [[], false]

  let replaced = false
  const newTrees = trees.map((tree, treeIdx) => {
    // return replaceNodeInTree(node, tree)
    // console.log('tree.name', tree, 'node.name', node.name)
    if (tree.name === node.name) {
      // console.log('TREE NAME MATCHES', tree.name)
      replaced = true
      return node
    } else {
      // check if the children contain
      const [resTrees, resReplaced] = replaceNodeInTrees(node, tree.children)
      if (resReplaced) replaced = true
      // console.log('replaceNodeInTrees', resTrees, resReplaced)
      return Object.assign(tree, { children: resTrees })
    }
  })

  // console.log('RETURNING NEW TREES', JSON.stringify(newTrees))
  // printTrees(newTrees)

  // will have to add node back if it hasn't been replaced
  return [newTrees, replaced]
}

const buildTreesFromData = data => {
  let trees = []
  let nodes = {}

  data.map((d, idx) => {
    // split the data
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

const partA = input => {
  const sortedTrees = buildTreesFromData(helpers.splitByNewLine(input))
  return sortedTrees[0].name
}

  // ---- OLD
  // const split = helpers.splitByNewLine(input)


  // let data = split.map((s,idx) => {
  //   const splitBySpace = s.split(' ')

  //   const weight = Number(splitBySpace[1].slice(1, -1))
  //   // console.log('weight', weight)

  //   let res = {
  //     name: splitBySpace[0],
  //     weight
  //   }
  
  //   if (splitBySpace.length === 2) { // no children
  //   } else { // indexs 3 onwards are the children
  //     const children = splitBySpace.splice(3).join('').split(',').map(c => ({ name: c}))
  //     res.children = children
  //   }

  //   return res
  // })
  // let names = data.map(d => d.name)

  // // printTrees(data)
  // // console.log('data', data)
  // // console.log('names', names)

  // // for(let i=0; i<13; i++){

  // let replaceTimer = 100
  // while(data.length > 1){
  //   if (replaceTimer-- === 0) break;
  //   // console.log(`I=${i}`)
  //   const first = data.splice(0, 1)[0]

  //   // console.log('FIRST', first)
  //   // console.log('DATA', data)

  //   // console.log('pre newData')
  //   const [newData, replaced] = replace(data, first)
  //   data = newData
  //   // console.log('post newData')
  //   // printTrees(newData)
  //   // console.log('newData', JSON.stringify(newData), replaced)
    
  //   if(!replaced) {
  //     // console.log(`not replaced [${first.name}]`)
  //     data.push(first)
  //   } else {
  //     replaceTimer = 100
  //   }

  //   // printTrees(data)

  // //   if(!first.children) {
  // //     data.push(first) // no children, push back on stack
  // //   } else {

  // //   }
  //   // console.log()
  // }

  

  // // console.log('PRINTING')
  // // printTrees(data)
  // data = data.map((d,idx) => {
  //   // console.log(`d[${idx}] ${d.name}`)
  //   // console.log(`data[${idx}] length[${countChildren(d)}]`)
  //   return Object.assign(d, { length: countChildren(d) })
  // })
  // .sort((a,b) => b.length - a.length)

  // // data.map((d,idx) => {
  // //   console.log(`[${idx}] [${d.length}]`)
  // // })


  // fakePartB(data[0])



  // return data[0].name
// }


// const replace = (data, which) => {
//   let replaced = false

//   // console.log(`replaceWhich [${JSON.stringify(which)}]`)

//   const newData = data.map((d,idx) => {
//     // console.log(`[d, ${idx}, ${d.name}]`)
//     // children
//     if (d.name === which.name) {
//       replaced = true
//       // console.log('NAMES MATCH [',which.name,']')
//       return which
//     } else {
//       if (d.children && d.children.length > 0){
//         const [children, replacedChildren] = replace(d.children, which)

//         // console.log('REPLACE', which.name, children)

//         if(replacedChildren) {
//           // console.log('replacedChildren')
//           replaced = true
//         }

//         return { name: d.name, children, weight: d.weight }
//       }
//       return d
//     }
//   })

//   // console.log('REPLACE END', which.name)
//   // console.log('data', JSON.stringify(data))
//   // console.log('newData', JSON.stringify(newData))
//   // console.log()

//   // print(newData)
//   // which = { name: 'pbga', ?children: [] }
//   /* data = [ 
//     {}, 
//     {}, 
//     {}, 
//     { children: [ 
//       {}, 
//       {}, 
//       { children: [ 
//         { name: 'pgba' }
//       ]
//     }]
//   }] */

//   return [newData, replaced]
// }

// const countChildren = tree => {
//   let count = 0
  
//   // console.log('tree', tree.name, tree.children ? tree.children.length : 'no children')
//   if (!tree.children) return count
//   if (tree.children.length === 0) return count

//   tree.children.map(c => {
//     count += 1

//     if (!c.children) return

//     c.children.map(c2 => {
//       count += countChildren(c2)
//       return c2
//     })

//     return c
//   })

//   return count
// }

// const printTrees = trees => {
//   console.log('Printing trees is better than printing paper', trees.length) 
//   // return
//   trees.map((d,idx) => {
//     console.log(`PRITING TREE [${idx}]`)
//     printTree(d)
//   })
//   console.log()
// }

// const printTree = (tree, n = 1) => {
//   let lines = ' '
//   let temp = n
//   while(temp-- > 0) lines += '-'
//   console.log(`${lines} ${tree.name} children[${tree.children ? tree.children.length : 'x'}]`)

//   if(tree.children){ 
//     tree.children.map(c => printTree(c, n + 1))
//   }
// }


// const printTreeWithWeights = (tree, n = 1) => {
//   let lines = ' '
//   let temp = n
//   let weight = tree.weight
//   while(temp-- > 0) lines += '-'

//   let childrenWeights = []
//   if(tree.children){ 
//     tree.children.map(c => {
//       const w = printTreeWithWeights(c, n + 1)
//       childrenWeights.push({ name: c.name, weight: w})
//       weight += w
//     })
//   }
//   console.log(`${lines} ${tree.name} ${weight}`)

//   if (childrenWeights.length > 0){
//     let combined = 0
//     childrenWeights.map(c => {
//       combined += c.weight
//       console.log(`cw: ${c.name}: ${c.weight}`)
//     })
//     combined /= childrenWeights.length

//     if (combined !== childrenWeights[0].weight) {
//       console.log('ERROR', childrenWeights)
//     }
//   }
  

//   return weight
// }

// const fakePartB = tree => {
//   console.log("PART B")

//   printTreeWithWeights(tree)
// }

// vrgxe is 1226, but it 7 too heavy, new weight = 1219

const partB = input => {
  return 2
}

export default {
  a: partA,
  b: partB
}