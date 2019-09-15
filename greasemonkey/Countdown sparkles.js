// ==UserScript==
// @name        Countdown spakliness
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/countdown_spakles
// @include     *itsalmo.st*
// @exclude     none
// @version     4
// @description:en	Makes your countdown sparkly!
// @grant    		none
// @description	Makes your countdown sparkly!
// ==/UserScript==

function changeColor() {
  const footerElements = document.getElementsByClassName('app-footer');
  
  if(footerElements.length > 0) {
    const footer = footerElements[0];
    footer.style.display = 'none';
  }

  const r = Math.floor((Math.random() * 255)); 
  const g = Math.floor((Math.random() * 255)); 
  const b = Math.floor((Math.random() * 255)); 
  
  const backgroundElements = document.getElementsByClassName('countdown-display');
  
  if(backgroundElements.length > 0) {
  	const background = backgroundElements[0];
    background.style.transition = 'all 1.5s ease-in-out';
    background.style.backgroundColor = `rgb(${r}, ${g}, ${b})`;
  }
  
  const textElements = document.getElementsByClassName('countdown-timer-wrap');
  
  if(textElements.length > 0) {
  	const text = textElements[0];
    text.style.transition = 'all 1.5s ease-in-out';
    const brightness = (r + g + b) / (255*3);
    if(brightness < 0.4) {
    	text.style.color = 'white';
    } else {
    	text.style.color = 'rgb(17, 18, 54)';
    }
  }
  
}

function worker() {
  try {
    changeColor();
  } catch (e) {
    console.log(e);
  }
}

setInterval(worker, 1500);

