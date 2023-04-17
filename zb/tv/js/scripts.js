$(document).ready(function(){

	$(".playignitor, .thumbnail").click(function() {		const player = videojs('player');

    	player.src({

      		src: $(this).attr('data-source'),

      		type: 'application/x-mpegURL'

    	});

	});

});
