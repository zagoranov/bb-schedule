// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

//= require bootstrap

$(document).ready(function() {

  $('#fbshare-link').click(function (event) {
     FB.init({ 
        appId:'807546819296222', cookie:true, 
        status:true, xfbml:true 
     });
    FB.ui({ method: 'feed', 
        message: 'While you were thin, i am visiting my gym.',
        name: 'EvenLift.ru',
        link: 'http://www.evenlift.ru/',
        picture: 'http://www.evenlift.ru/icon200.png',
        caption: '5/3/1 Calculator and Training Diary',
        description: 'EvenLift.ru helps you calculate «5/3/1» routine. Besides, you can track your trainings, check body weight chart, look training history and etc.'
        });
     event.preventDefault(); // Prevent link from following its href
  });

});