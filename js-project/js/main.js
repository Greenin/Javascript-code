$(document).ready(function(){
	
	if (window.location.href.indexOf('index')>-1)
	{
		$('.gallery').bxSlider({
			mode: 'fade',
			captions: true,
			slideWidth: 900
		});
	}
	
	if (window.location.href.indexOf('index')>-1)
	{
		//Posts
		var posts = [
			{
				title: 'Title Test 1',
				date: 'Publish on ' + moment().format("MMMM") + " " + moment().date() + ", " + moment().format("YYYY"),
				content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
			},
			{
				title: 'Title Test 2',
				date: 'Publish on ' + moment().format("MMMM") + " " + moment().date() + ", " + moment().format("YYYY"),
				content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
			},
			{
				title: 'Title Test 3',
				date: 'Publish on ' + moment().format("MMMM") + " " + moment().date() + ", " + moment().format("YYYY"),
				content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
			},
			{
				title: 'Title Test 4',
				date: 'Publish on ' + moment().format("MMMM") + " " + moment().date() + ", " + moment().format("YYYY"),
				content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
			},
			{
				title: 'Title Test 5',
				date: 'Publish on ' + moment().format("MMMM") + " " + moment().date() + ", " + moment().format("YYYY"),
				content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
			},
			{
				title: 'Title Test 6',
				date: 'Publish on ' + moment().format("MMMM") + " " + moment().date() + ", " + moment().format("YYYY"),
				content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
			},		
		]
		
		posts.forEach((item, index) => {
			var post = `
			<article class="post">
				<h2>${item.title}</h2>
				<span class="date">${item.date}</span>
				<p>
					${item.content}
				</p>
				<a href="#" class="button-more">Read more</a>
			</article>
				`;
				
				$("#posts").append(post);
		});
	}
	
	
	//Theme selector
	var oTheme = $("#theme");

	$("#to-green").click(function(){
		oTheme.attr("href","css/green.css");
	});

	$("#to-red").click(function(){
		oTheme.attr("href","css/red.css");
	});
	
	$("#to-blue").click(function(){
		oTheme.attr("href","css/blue.css");
	});
	
	
	//Scroll at the web top
	$('.go-up').click(function(e){
		e.preventDefault();

		$('html,body').animate({
			scrollTop: 0
		}, 500);
		
		return false;
	});
	
	//Fake login
	$("#login form").submit(function(){
		var form_name = $("#form_name").val();
		
		localStorage.setItem("form_name",form_name);
	});
	
	var sForm_name = localStorage.getItem("form_name");

	if (sForm_name != null && sForm_name != "undefined") {
		var oParagraph = $("#about p");

		oParagraph.html("<br><strong>Welcome, "+ sForm_name+"</strong> ");
		oParagraph.append("<a href='#' id='logout'>Log out</a>");

		$("#login").hide();
		
		$("#logout").click(function(){
			localStorage.clear();
			location.reload();
		})
	}
	
	
	//Accordion
	if (window.location.href.indexOf('about')>-1)
	{
		$('#accordion').accordion();
	}
	
	//Clock
	if (window.location.href.indexOf('clock')>-1)
	{
		setInterval(function(){
			var oClock = moment().format('hh:mm:ss');		
			$('#clock').html(oClock);
		},1000);

	}
	
	
	//Validation
	if (window.location.href.indexOf('contact')>-1)
	{
		$("form input[name='date']").datepicker({
			dateFormat: 'dd-mm-yy'
		});
		
		$.validate({
			lang: 'es',
			errorMessagePosition: 'top',
			scrollToTopOnError: true
		});
	}
	
	
})