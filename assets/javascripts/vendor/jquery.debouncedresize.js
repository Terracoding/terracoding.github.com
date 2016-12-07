/*
 * debouncedresize: special jQuery event that happens once after a window resize
 *
 * latest version and complete README available on Github:
 * https://github.com/louisremi/jquery-smartresize
 *
 * Copyright 2012 @louis_remi
 * Licensed under the MIT license.
 *
 * This saved you an hour of work?
 * Send me music http://www.amazon.co.uk/wishlist/HNTU0468LQON
 */
!function(e){var n,t,i=e.event;n=i.special.debouncedresize={setup:function(){e(this).on("resize",n.handler)},teardown:function(){e(this).off("resize",n.handler)},handler:function(e,r){var o=this,s=arguments,u=function(){e.type="debouncedresize",i.dispatch.apply(o,s)};t&&clearTimeout(t),r?u():t=setTimeout(u,n.threshold)},threshold:150}}(jQuery);