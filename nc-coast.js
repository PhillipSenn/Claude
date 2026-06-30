var images = [
  {
    url: 'https://static.wixstatic.com/media/623b75_b1fd10f1be3b4175b0f69b8ac5fc3966~mv2.jpg',
    caption: 'A wooden platter with diverse food dishes'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_0d4fff64b7304fa483feceb321abc797~mv2.jpg',
    caption: 'Grilled sandwich with fries on a plate'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_1c1d4e46fac74c4f8dd456f4a3bf7078~mv2.jpg',
    caption: 'Tropical cocktail with coconut flakes and black straw'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_8572510e89c74c32a4f0b89671f102cc~mv2.jpg',
    caption: 'Wooden pier stretches over calm water during a vibrant sunset'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_6c592f7dab1e469c9d33ed58cc8203b3~mv2.jpg',
    caption: 'Seafood pasta with scallops, shrimp, and herbs'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_5b04b5233ca748cabc0eef0c51cd60f2~mv2.jpg',
    caption: 'Patrons dining at NC Coast Grill &amp; Bar'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_f24175377f43420393b9084d98910728~mv2.jpg',
    caption: 'Grilled salmon bowl with rice, avocado, and vegetables'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_56263fd9e22c4b72ada68af01250a9c4~mv2.jpg',
    caption: 'Outdoor dining with water views'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_64bcf7fe095049858b215fda491dc43a~mv2.jpg',
    caption: 'Two people dining with ocean pier background'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_8b366e2f97364a48b0f766432c8ec49c~mv2.jpg',
    caption: 'Dramatic sky over water with pier and glowing sunset reflection'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_0bf9fb560bcb4e0ea0ee5c27b476316a~mv2.jpg',
    caption: 'Server holding a wooden platter with various appetizers'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_ae8590b1d8124f8ca00ebc45f7097984~mv2.jpg',
    caption: 'Pink cocktail with mint and lemon garnish'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_280fba5fa29a451987e49687c1617a89~mv2.jpg',
    caption: "The Chef's Board — part showstopper, part flavor adventure"
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_28b0a2bc25464c82935622e62b7a87e1~mv2.jpg',
    caption: 'Seafood pasta dish in a white bowl with mixed ingredients'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_0f5497ece57647ca85f3137c3a8f6437~mv2.jpg',
    caption: 'Restaurant interior with many patrons enjoying food and drinks'
  },
  {
    url: 'https://static.wixstatic.com/media/623b75_b99116cf8ab64afb8310384091020db9~mv2.jpg',
    caption: 'Birthday cake with lit candles in the restaurant kitchen'
  },
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAHWmA7m1ngfs9_S3hvSknV3sao77weyBjWcBWlvuBSpr1zuqJmPseTJIMQ_uln8t4fOZ6wqvpP7H5misGLjGcIv0wE-A7RTpRBnToSqE4_E5hnKokD9zN29FVucMAygzOUBsQhE=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAFnEK8YGnrxCvDPf8Pqj86EzDE3POeZI4nkGWv5bVusZLvsrGY9FqUnsU5k5dHwlwTYgOsv0Hi2kfCzeOFsES6B-HgPzYk1ueUCeM0YmArjCgKn4ni2LFKFCR57cBO-MCZfNlZ0=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAFjNlCmC6toSW8SfSPFkoevYkeZIQALCDMImHXxR3vm17exrXDjUy4B-j09h7KYHdrdPJaLu0elnud16-wjOzEGlx5POcmGeEm6GW0izpQ7olyUEez2oRQ1Kop6OX0sLnfh3Lo=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAGuWZSex6s0vGNrv7FtEZ_uInSRJoj6Gt4m6yovTz99WBRD4sEF0I12_-3DV2Rg91z8ZM2XmGYyEno7QMR0aUl68bCBhGRFs-vujkU7tFkqoFqKXaFUxx3t1rznSfkesnhwf8632xsBWGuI=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAEJYESZs_e-1-y5Meeoc7OxTx4HS-xvtaze-0WSavLC12o08ivNpXdArrWgeMybJaEm88ztzBOyJ5vsLdIdhU9xN6YtrJkcKwkFIMazbVZXuo1hdI_h95dJJ7rULynmC3JfmLGA=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAHIMBZUELZazS9SSesoyVMEl1n-O3mPOKduNrqvuDqJET3Vn4k4hMDBxVykY-CD8pCIViE-_tSadd0NJuCQdgKWk-pOT64ajAlJf7Nn8-foBwg4yUiSkGzP3ndNXwmNQugDeN7B=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAEVpoTaeMAdlMlwUpMYYCnxlEAk9gJPzxP2yJECJGWkb9oT-PD2Eu5c8mj_xx7U-ezPKzKUlMcoF0nH4upjxCZqJhOuDfAiOWiLRZGcWLfPpQhxvxDkuhNNPZOjwec-m4nE4egxwz6FS38=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAElu1xX3vRJd5YuWU-cvulL8VzDfLOt4_VciPpIwNFAoaa5D9UHu3yVZgoR6w7rROLb1vtrmYNHTXhxvdqZCyFDjSV7GBrme1wE4x_N7lH9uVnCKTZj2KdnKinsByq3knEiEkvfAR9FtVjT=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAFe4_UCYx-SwXYll3tUVoSjyWV9nNeEjmxQeWiL4NNUyGHVZQKcPZp8nIFZsxDnHalXPidzd6k4JCU9efO_fA0gLcEu3uA8TkhnIfDrtoQKgfquydzH9rosvx9i-ALASMJVOUaydA=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAGOsMKoEs2ye87LE2zvY7btZaaIX_9Pe5XjfFtdfOEJ8MctQCqunBvWhoRsVboMhhDYrKZqbyCYdIWyfNai2FeWkn3aQXQ3LKZ6qvWemMoiSUTu8M3lMYuukDfmuDLqtaWe47nJQg=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAGlqgY-1QqaWsaZpFeomk_bpwJHA95fYpzpK602ijiZVJXGmt-QxP20TPwafYp9e8Td51b1LoD-QZgELIV65dx2JHBhgx97fv1BwUC-oLQiREDafqd8-QrQOSzs8UOvkgspV9eE=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAEKCgPtD-FnOAqNGxCPYKMLakcLKzColZlS3cWbd6vj9SwycgGYwOLpB6iVL6Fnp4GkrYb3yRKxsNU6cbhjTtUBAOnr73ckkfTwivPIsMzonuU0TNeisnu7NzojM7Q88BX8j5I1_bs6dNAl=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAFdSAHDcfm7iEq5OvCwTczMrmFRr-iUzmIDiNB6XMUdDPHDtSeciS56H7x1s8Q-SdA7-FGT2ippykA5FbUvexorBTnFqX9aQ_vjWZmImEjDQVvIpYqptsf7qJbFbScuLUJctQGQ9blGu8Mn=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAHCFGvkR9_-D5DgyKYN-xw0Y5rfDRej1ExrAttSvkSaWG21w202Mhmq_oDn1ea6gGOgGdQu-R59QVFmlDSSX-YEHiPpzLJTDjQMxNnHVkoNebY7OxYVjyQ1S_lPAsg-Y5zQI01b1Q=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAE9LuUbKhUCcPMstv742zyRcntwA5Yh7fwXNtjwepmy-w-MJH72zn2_Dt7AcugLFXH-3vtKmSRYZeCLl6ECsfpYhxrK-Y7kFvQzg58VqIwwwUEWI2n-4i_vtpHsFyuP_S_ipErVtA=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAFvLyBzUN8Suv56wFcWHmMC61elH8IhDVY9KHRvHtBQVUfLw0pl3z4rDkRAeHO0igx2YL5qYn6R20Zk1nl0NevH7z1tsOGgF4x3s3rFWIjq3LYSwg5nCOjrrpTpk5i2vQoQm7dCPyvXf8E=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAH0C4sW5MD6BUEkXLw9P0HHISDeOsK-d5RnGNUu9a9rnV0bCtFvqfIWoDXLGLAtGeQaqE05q_80zpo_8xk-5NSBCRSb12NUJWQDoeYPTFPM0vdCfasFv2TJqmqzAeFeZV7ZkPcCuHM8I8FL=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAGFzIK3CE0lTxfDRobOaQqPuICoDSPsNoQy9TQF9m_QQwu9BZTVevARtYPVhkPso8AR-PU8FYN1dyqS48OqCd6B8P95ckikmKVe4X2qj0GmdnKsE1cnQ4O11FnrA0BRDFV1LntNAMaF4uNT=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAHJ-fljeSBYphKVe-ga5aZN1u6Xz3XTeQXjYlzkCku_h-LeijlHFJgtS6XJJZw-XJ4DkZ-8xXVFnuq4Q5jQNWtaJbsIdhdtSpCMu9oSEz8QCvTgNb7ZZ5hZBm8zL0xeeoQNpu8=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAEQMzOY5vPtUAkwjsZToMME6CKae6kz502CiQkoAx3_SrR-il8ftjcOoDcuVga7TvBVEtmu9ChYLs-Qy6cGAXY5cXRynmMsAEP4Qc3EaXpfpAKBDtXMtXgpFHOG45c_DMoXBB8O=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAGqee4mseq9UZikl5vc1gDh_djjXCnsCgw9E1XgSh_YWPNir2Ob1Eyx6qEs7uvlNVHVu6DwMq8Y3MyBpLIbm5iNPMYK5H0Yom4Y1gXpDTi5BfViblRxmg8htNXt2BohThnv7yLJ6K8LFobY=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAGT9QDslYwOJbVFXfNCkeXaNF4ajN2ii3f5vvD1U8JTG6gJ0YYc8rfdAO4oZVsjRHgwx_ySMYdBb5GlpavIeTLS_Yc46jQ_oPg2VKSYRN6oHJi6cKp9EZ_xZzjHAOqRkY8_jHTy=w1200-h800-k-no', caption: ''},
  {url: 'https://lh3.googleusercontent.com/gps-cs-s/APNQkAE11Xz1L3xd76H3zC8ZsKrjgGhgfDH24ocFZxASn8zx5gIUVhv2IYdM1-Sqr9F8vVOtO3Y44UsF_TXpTR2R48obq0Yq_CJCLwfD-wg7YMzaafQZZ81CtU4YbWLFz8L3qvBxanUNvg=w1200-h800-k-no', caption: ''}
]

var currentIndex = 0

function showImage(index) {
  currentIndex = index
  var image = images[currentIndex]
  $('#photo-img').attr('src', image.url).attr('alt', image.caption)
  $('#photo-caption').html(image.caption)
  $('#photo-counter').text((currentIndex + 1) + ' of ' + images.length)
}

function nc_prev() {
  var index = currentIndex - 1
  if (index < 0) {
    index = images.length - 1
  }
  showImage(index)
}

function nc_next() {
  var index = currentIndex + 1
  if (index >= images.length) {
    index = 0
  }
  showImage(index)
}

function handleKeydown(e) {
  if (e.which === 37) {
    nc_prev()
  } else if (e.which === 39) {
    nc_next()
  }
}

var touchStartX = 0
var swipeDir = 0

function handleTouchStart(e) {
  touchStartX = e.originalEvent.changedTouches[0].screenX
  $('#photo-img').css('transition', 'none')
}

function handleTouchMove(e) {
  var diff = e.originalEvent.changedTouches[0].screenX - touchStartX
  $('#photo-img').css('transform', 'translateX(' + diff + 'px)')
}

function afterSlideOut() {
  if (swipeDir > 0) {
    nc_prev()
  } else {
    nc_next()
  }
  $('#photo-img').css('transition', 'none')
  $('#photo-img').css('transform', 'translateX(0)')
}

function handleTouchEnd(e) {
  var diff = e.originalEvent.changedTouches[0].screenX - touchStartX
  if (Math.abs(diff) < 50) {
    $('#photo-img').css('transition', 'transform 0.2s ease')
    $('#photo-img').css('transform', 'translateX(0)')
    return
  }
  swipeDir = diff
  var slideOut = diff > 0 ? '100%' : '-100%'
  $('#photo-img').css('transition', 'transform 0.25s ease')
  $('#photo-img').css('transform', 'translateX(' + slideOut + ')')
  setTimeout(afterSlideOut, 250)
}

$(document).on('click', '.nc-prev', nc_prev)
$(document).on('click', '.nc-next', nc_next)
$(document).on('keydown', handleKeydown)
$('#photo-frame').on('touchstart', handleTouchStart)
$('#photo-frame').on('touchmove', handleTouchMove)
$('#photo-frame').on('touchend', handleTouchEnd)

$(document).ready(ready)

function ready() {
  showImage(0)
}
