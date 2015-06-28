Number::times = (fn) ->
  do fn for [1..@valueOf()] if @valueOf()

Array::repeat = (n, list) ->
  [].concat (n.times -> list)...

global.carthesianProduct = ->
  args = [].reverse.call [].slice.call arguments
  end = args.length - 1
  result = []

  addTo = (curr, start) ->
    first = args[start]
    last = (start == end)
    for i in [0..first.length-1]
      copy = curr.slice()
      copy.unshift first[i]

      if last
        result.push copy
      else
        addTo copy, start+1

  if args.length
    addTo [], 0
  else
    result.push []

  result
