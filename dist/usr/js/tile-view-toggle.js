(function(){
  const ready = function (fn) {
    /* MIT License Copyright (c) 2016 Nuclei */
    /* https://github.com/nuclei/readyjs */
    const completed = () => {
      document.removeEventListener('DOMContentLoaded', completed)
      window.removeEventListener('load', completed)
      fn()
    }
    if (document.readyState !== 'loading') {
      setTimeout(fn)
    } else {
      document.addEventListener('DOMContentLoaded', completed)
      window.addEventListener('load', completed)
    }
  }
  ready(function(){
    const toggleElement = el => {
      el.style.display = el.style.display === 'none' ? '' : 'none'
    }
    
    const remarkSlideShow = document.querySelector('div.remark-slides-area')
    
    let tileView = document.querySelector('div.remark__tile-view')
    
    const blockEvent = ev => ev.stopPropagation()
    
    const blockScaling = function (ev) {
      if (ev.controlKey || ev.metaKey) {
        if (ev.key === '=' || ev.key === '-') {
          ev.preventDefault()
          console.log('window scaling is not allowed inside the tile overview')
        }
      }
    }
    
    const tileVars = {currentSlideIdx: slideshow.getCurrentSlideIndex()}
    
    const toggleTileView = function () {
      toggleElement(tileView)
      toggleElement(remarkSlideShow)
    
      if (tileView.style.display === 'none') {
        // tileView is now hidden, go to current slide
        slideshow.gotoSlide(tileVars.currentSlideIdx + 1)
    
        // remove scroll/mousewheel event blocking
        tileView.removeEventListener('mousewheel', blockEvent)
        tileView.removeEventListener('DOMMouseScroll', blockEvent)
        console.log('removing blockScaling')
        document.removeEventListener('keydown', blockScaling)
      } else {
        // store current slide index prior to launching tile-view
        tileVars.currentSlideIdx = slideshow.getCurrentSlideIndex()
    
        // set class on seen and current slide and scroll into view
        const tiles = tileView.querySelectorAll('.remark__tile-view__tile');
        [...tiles].forEach((tile, idx) => {
          tile.classList.toggle(
            'remark__tile-view__tile--seen',
            idx < tileVars.currentSlideIdx
          )
          tile.classList.toggle(
            'remark__tile-view__tile--current',
            idx === tileVars.currentSlideIdx
          )
        })
        tiles[tileVars.currentSlideIdx].scrollIntoView({
          behavior: 'smooth',
          block: 'center'
        })
    
        // block remarkjs from handling scroll events
        tileView.addEventListener('mousewheel', blockEvent)
        tileView.addEventListener('DOMMouseScroll', blockEvent)
        console.log('adding blockScaling')
        document.addEventListener('keydown', blockScaling)
      }
    }
    document.getElementsByClassName('my-header').forEach(
      e => e.addEventListener("click", toggleTileView)
    );
  })
})()