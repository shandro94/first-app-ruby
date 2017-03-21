function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

function mouseEnterLeaveActions(obiect) {
	$(obiect)
	.on( "mouseenter", function() {
		$( this ).css('background-color',getRandomColor());
	})
	.on( "mouseleave", function() {
		$( this ).css('background-color','white');
	});
}