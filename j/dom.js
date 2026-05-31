/*
  q.js — lightweight jQuery replacement
  Exposes a single $ global.

  Supported:
    $(selector)                        — query returning a NodeList wrapper
    $(document).on(event, sel, fn)     — delegated event listener
    $(document).off(event, sel, fn)    — remove delegated listener
    $(el).on(event, fn)                — direct listener on element(s)
    $(el).off(event, fn)               — remove direct listener
    $el.html(str)                      — get/set innerHTML
    $el.text(str)                      — get/set textContent
    $el.val(str)                       — get/set value
    $el.attr(name, val)                — get/set attribute
    $el.addClass(cls)                  — add class
    $el.removeClass(cls)               — remove class
    $el.toggleClass(cls)               — toggle class
    $el.show()                         — display:block
    $el.hide()                         — display:none
    $el.each(fn)                       — iterate nodes
    $el.find(selector)                 — query within matched nodes
    $el.closest(selector)              — walk up the DOM
    $el.first()                        — first matched node
    $el.last()                         — last matched node
    $el.length                         — node count
    $.ready(fn)                        — DOMContentLoaded shortcut
*/

;(function (global) {

  /* ─── internal store for delegated listeners ─── */
  /*
    Key: element (WeakMap)
    Value: array of { event, selector, fn, wrapped }
    "wrapped" is the real listener attached to the element so we can remove it.
  */
  var delegateStore = new WeakMap()

  /* ─── wrap a raw node or NodeList in a Q object ─── */
  function Q(nodes) {
    this.nodes = nodes instanceof NodeList || Array.isArray(nodes)
      ? Array.from(nodes)
      : nodes != null ? [nodes] : []
    this.length = this.nodes.length
  }

  /* ─── iterate helper used internally ─── */
  function eachNode(q, fn) {
    q.nodes.forEach(fn)
    return q
  }

  /* ─── build a delegated-listener wrapper function ─── */
  function buildWrapper(selector, fn) {
    return function handleDelegated(e) {
      var target = e.target
      while (target && target !== e.currentTarget) {
        if (target.matches && target.matches(selector)) {
          fn.call(target, e)
          return
        }
        target = target.parentElement
      }
    }
  }

  /* ─── prototype methods ─── */
  Q.prototype = {

    /* delegated: $(document).on('click', '.btn', handler)
       direct:    $(el).on('click', handler)              */
    on: function qOn(event, selectorOrFn, fn) {
      var isDelegated = typeof selectorOrFn === 'string'
      var selector    = isDelegated ? selectorOrFn : null
      var callback    = isDelegated ? fn : selectorOrFn

      return eachNode(this, function addListener(node) {
        if (isDelegated) {
          var wrapped = buildWrapper(selector, callback)
          node.addEventListener(event, wrapped)
          var entries = delegateStore.get(node) || []
          entries.push({ event: event, selector: selector, fn: callback, wrapped: wrapped })
          delegateStore.set(node, entries)
        } else {
          node.addEventListener(event, callback)
        }
      })
    },

    /* delegated: $(document).off('click', '.btn', handler)
       direct:    $(el).off('click', handler)              */
    off: function qOff(event, selectorOrFn, fn) {
      var isDelegated = typeof selectorOrFn === 'string'
      var selector    = isDelegated ? selectorOrFn : null
      var callback    = isDelegated ? fn : selectorOrFn

      return eachNode(this, function removeListener(node) {
        if (isDelegated) {
          var entries = delegateStore.get(node) || []
          delegateStore.set(node, entries.filter(function keepEntry(entry) {
            var match = entry.event === event
              && entry.selector === selector
              && entry.fn === callback
            if (match) {
              node.removeEventListener(event, entry.wrapped)
            }
            return !match
          }))
        } else {
          node.removeEventListener(event, callback)
        }
      })
    },

    html: function qHtml(str) {
      if (str === undefined) {
        return this.nodes[0] ? this.nodes[0].innerHTML : ''
      }
      return eachNode(this, function setHtml(node) {
        node.innerHTML = str
      })
    },

    text: function qText(str) {
      if (str === undefined) {
        return this.nodes[0] ? this.nodes[0].textContent : ''
      }
      return eachNode(this, function setText(node) {
        node.textContent = str
      })
    },

    val: function qVal(str) {
      if (str === undefined) {
        return this.nodes[0] ? this.nodes[0].value : ''
      }
      return eachNode(this, function setVal(node) {
        node.value = str
      })
    },

    attr: function qAttr(name, value) {
      if (value === undefined) {
        return this.nodes[0] ? this.nodes[0].getAttribute(name) : null
      }
      return eachNode(this, function setAttr(node) {
        node.setAttribute(name, value)
      })
    },

    addClass: function qAddClass(cls) {
      return eachNode(this, function addCls(node) {
        node.classList.add(cls)
      })
    },

    removeClass: function qRemoveClass(cls) {
      return eachNode(this, function removeCls(node) {
        node.classList.remove(cls)
      })
    },

    toggleClass: function qToggleClass(cls) {
      return eachNode(this, function toggleCls(node) {
        node.classList.toggle(cls)
      })
    },

    show: function qShow() {
      return eachNode(this, function showNode(node) {
        node.style.display = 'block'
      })
    },

    hide: function qHide() {
      return eachNode(this, function hideNode(node) {
        node.style.display = 'none'
      })
    },

    each: function qEach(fn) {
      return eachNode(this, fn)
    },

    find: function qFind(selector) {
      var found = []
      this.nodes.forEach(function collectFound(node) {
        node.querySelectorAll(selector).forEach(function addFound(el) {
          found.push(el)
        })
      })
      return new Q(found)
    },

    closest: function qClosest(selector) {
      var found = []
      this.nodes.forEach(function walkUp(node) {
        var match = node.closest ? node.closest(selector) : null
        if (match && found.indexOf(match) === -1) {
          found.push(match)
        }
      })
      return new Q(found)
    },

    first: function qFirst() {
      return new Q(this.nodes[0] || null)
    },

    last: function qLast() {
      return new Q(this.nodes[this.nodes.length - 1] || null)
    }

  }

  /* ─── the $ factory ─── */
  function $(selectorOrNode) {
    if (selectorOrNode === document || selectorOrNode instanceof Node) {
      return new Q(selectorOrNode)
    }
    if (typeof selectorOrNode === 'string') {
      return new Q(document.querySelectorAll(selectorOrNode))
    }
    if (selectorOrNode instanceof Q) {
      return selectorOrNode
    }
    return new Q(null)
  }

  /* ─── $.ready(fn) — run after DOM is parsed ─── */
  $.ready = function qReady(fn) {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', fn)
    } else {
      fn()
    }
  }

  global.$ = $

}(window))
