var ready = function() {

  chatBox = {

		//Plays notification sound when a new chat message arrives
		notify: function() {
			var audioPlayer = $('#chatAudio')[0];
			audioPlayer.play();
		},

    /**
	   * Responsible for listening to the keypresses when chatting. If the Enter button is pressed,
	   * we submit our conversation form to our rails app
	   *
	   * @param event
	   * @param chatboxtextarea
	   * @param clas_room_id
	 	 */

    checkInputKey: function(event, chatboxtextarea, clas_room_id) {
	 		if (event.keyCode == 13 && event.shiftKey == 0) {
	 			event.preventDefault();

	 			var message = chatboxtextarea.val();
	 			message = $.trim(message);

	 			if (message != '') {
	 				$('#class_room_' + clas_room_id).submit();
	 				$(chatboxtextarea).val('');
	 				$(chatboxtextarea).focus();
	 				// $(chatboxtextarea).css('height', '44px');
	 			}
	 		}
 	  },
	}
}
$(document).ready(ready);
