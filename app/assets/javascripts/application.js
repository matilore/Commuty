// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .

var pId;


function createParClass() {
		var arrayParagraphs = $('.main-content p')
		for (var i = 0; i < arrayParagraphs.length; i++) {
			var idName = 'par'+ i;
			$(arrayParagraphs[i]).attr('id', idName);
			$(arrayParagraphs[i]).append("<span style='width:6px;'class='glyphicon glyphicon-pencil pull-right hide' aria-hidden='true'></span>");
			$(arrayParagraphs[i]).append("<span style='width:6px; 'class='glyphicon glyphicon-sunglasses pull-right hide' aria-hidden='true'></span>");
			//inserire qui un pulsante per aggiungere commento con identificatore tag

		};
	}

	function showComments() {
		$('.main-content p span.glyphicon-sunglasses').click(function(event){
			pId = $(event.target).parent().attr('id');
			

		if (!($(event.target).hasClass('commentShowing'))) {
			retrieveComment();			
			$(event.target).toggleClass('commentShowing');
		} else {
			$('.comment ul').children("." + pId).remove();
			$(event.target).toggleClass('commentShowing')
			}
		});
	}

	function writeComments() {
		$('.main-content p span.glyphicon-pencil').click(function(){
			$('.form-group-comment').toggleClass('hide');

			$(this).parent().toggleClass('highline');
			var pId = $(this).parent().attr('id');
			var hiddenField = $('<input>');
			$('.form-group-comment').append(hiddenField);
			console.log(hiddenField);
			hiddenField.attr('type', 'hidden').attr('name', 'comment[paragraph_id]');
			hiddenField.attr('value', pId);

		})
	}

	function commentMode() {
		$('.comment-mode').click(function(){
			if ($('.main-content p span').hasClass('hide')) {
				$(this).text('Read Mode');
				$('.main-content p span').toggleClass('hide');
			} else {
				$(this).text('Comment Mode');
				$('.main-content p span').toggleClass('hide');
			}
			
		});

		
	}

	function createPopups() {
		var spanAction = ['Write a comment', 'Read a comment'];
		$('.main-content p span').mouseover(function(event){
			if ($(event.target).hasClass('glyphicon-pencil')) {
				$(event.target).attr('title', spanAction[0]);
			} else {
				$(event.target).attr('title', spanAction[1]);
			}
		});
	}


	function retrieveComment(){
	var URL = 'http://localhost:3000/comments/' + post_id;

		$.ajax({
			url: URL,
			dataType: 'json',
			success: retrieveData,
			error: handleError
		});
	}



	function retrieveData(data) {
		var commentList = $('.comment ul');
		for (var i = 0; i < data.length; i++) {
			if (data[i].paragraph_id == pId) {
				$($('<li>').addClass('list-group-item col-md-10 ' + pId).text(data[i].content)).appendTo(commentList);
			};
		}
	}

	function handleError(req, status, error) {
		console.log("there has been an  error " + error);
	}

$(document).ready(function(){
	$('.diffs-btn').click(function() {
		var modal = $('.diffs-modal').modal('show');
	});

	createParClass();
	showComments();
	writeComments();
	commentMode();
	createPopups();
	
});