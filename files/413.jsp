<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>Request Entity Too Large</title>
	<style>
		* {
			margin: 0;
			padding: 0;
		}

		html, body {
			min-height: 100%;
		}

		body {
			position: relative;
			font-size: 11px;
			font-family: Verdana, sans-serif;
			background: #0a2b4f; /* Old browsers */
			background: -moz-linear-gradient(top, #0a2b4f 0%, #539ab8 100%); /* FF3.6+ */
			background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #0a2b4f), color-stop(100%, #539ab8)); /* Chrome,Safari4+ */
			background: -webkit-linear-gradient(top, #0a2b4f 0%, #539ab8 100%); /* Chrome10+,Safari5.1+ */
			background: -o-linear-gradient(top, #0a2b4f 0%, #539ab8 100%); /* Opera 11.10+ */
			background: -ms-linear-gradient(top, #0a2b4f 0%, #539ab8 100%); /* IE10+ */
			background: linear-gradient(to bottom, #0a2b4f 0%, #539ab8 100%); /* W3C */
		}

		a {
			color: #333;
		}

		.errorBody {
			min-height: 780px;
			padding-top: 120px;
		}

		.errorBox {
			color: #333;
			position: relative;

			margin-left: auto;
			margin-right: auto;

			width: 880px;
			height: 300px;
			padding: 40px;

			background-color: rgba(255, 255, 255, 0.9);

			border-radius: 15px;
			box-shadow: 3px 3px 10px #333;
		}

		.statusCode,
		.statusText {
			width: 320px;
			text-align: center;
			color: #555;
		}

		.statusCode {
			margin-top: 40px;
			font-size: 148px;
			font-weight: bold;
		}

		.statusText {
			font-size: 24px;
		}

		.errorDescription {
			position: absolute;
			top: 40px;
			right: 40px;
			width: 490px;
			height: 300px;
			padding-left: 30px;
			border-left: 1px solid #e0e0e0;
		}

		.todo {
			position: absolute;
			bottom: 0;
			width: 490px;
		}

		@media (max-width: 980px) {
			.errorBody {
				padding-top: 0;
			}

			.errorBox {
				width: auto;
				height: auto;
				margin: 10px;
			}

			.statusCode {
				margin-top: 0;
			}

			.statusCode,
			.statusText {
				width: auto;
				text-align: center;
			}

			.errorDescription {
				position: relative;
				top: inherit;
				right: inherit;
				width: auto;
				height: auto;
				padding-left: 0;
				border-left: 0;
			}

			.todo {
				position: relative;
				width: auto;
				bottom: inherit;
			}

			.description {
				margin-top: 16px;
				height: auto !important;
			}

			h2 {
				margin-top: 16px;
			}
		}

		@media (max-width: 430px) {
			.statusCode {
				font-size: 72px;
			}
		}

		.description {
			line-height: 16px;
			height: 100px;
		}

		h1.title {
			display: none;
		}

		h2 {
			font-size: 11px;
			margin-bottom: 20px;
		}

		.links ul li {
			float: left;
			line-height: 27px;
			margin-right: 20px;
			margin-bottom: -1px;
			height: 27px;
			width: 220px;
			border-top: 1px solid #b3c6cc;;
			border-bottom: 1px solid #b3c6cc;;
			list-style-type: none;
		}

		.links ul li:before {
			content: "\00BB\00A0";
		}

		.links ul li a {
			text-decoration: none;
			color: #333;
		}

		.links ul li a:hover {
			text-decoration: underline;
		}

		.tips ul li {
			line-height: 27px;
			margin-right: 20px;
			margin-bottom: -1px;
			border-top: 1px solid #b3c6cc;;
			border-bottom: 1px solid #b3c6cc;;
			list-style-type: none;
		}

		.tips ul li:before {
			content: "\00BB\00A0";
		}

		#locale-flags {
			display: none;
			position: absolute;
			top: 10px;
			right: 10px;
		}

					.en, .de, .hu, .ru {
				display: none;
			}
							html.locale-en .en {
					display: inline;
				}

				.locale-en .en, .locale-de .de, .locale-hu .hu, .locale-ru .ru {
					display: none;
				}

							html.locale-de .de {
					display: inline;
				}

				.locale-en .en, .locale-de .de, .locale-hu .hu, .locale-ru .ru {
					display: none;
				}

							html.locale-hu .hu {
					display: inline;
				}

				.locale-en .en, .locale-de .de, .locale-hu .hu, .locale-ru .ru {
					display: none;
				}

							html.locale-ru .ru {
					display: inline;
				}

				.locale-en .en, .locale-de .de, .locale-hu .hu, .locale-ru .ru {
					display: none;
				}

						</style>
</head>
<body>
<h1 class="title">
						<span class="en" id="title-en">Request Entity Too Large</span>
					<span class="de" id="title-de">Anfrage zu groß</span>
					<span class="hu" id="title-hu">A lekérdezés túl nagy</span>
					<span class="ru" id="title-ru">Размер запроса слишком велик</span>
			</h1>
<div class="errorBody">
	<div class="errorBox">
		<div class="errorData">
			<div id="locale-flags">
															<button id="set-locale-en">English</button> |<button id="set-locale-de">Deutsch</button> |<button id="set-locale-hu">Magyar</button> |<button id="set-locale-ru">Русский</button>												</div>
			<div class="statusCode">413</div>
			<div class="statusText">
															<span class="en">Too big!</span>
											<span class="de">Zu groß!</span>
											<span class="hu">Túl nagy!</span>
											<span class="ru">Слишком большой</span>
												</div>
		</div>
		<div class="errorDescription">
			<div class="description">
															<span class="en">
							Your browser sent us a waaaaay <strong>too large request</strong> which we couldn't process.
						</span>
											<span class="de">
							Ihr Browser hat uns eine viiiiel <strong>zu große Anfrage</strong> geschickt die wir nicht verarbeiten konnten.
						</span>
											<span class="hu">
							A böngészője túl nagy lekérdezést küldött.
						</span>
											<span class="ru">
							Ваш браузер послал слишком большой запрос, который мы не в состоянии обработать.
						</span>
												</div>
			<div class="tips todo">
									<h2>
																					<span class="en">Please follow these steps to get back on track:</span>
															<span class="de">Bitte versuchen sie folgendes:</span>
															<span class="hu">Próbálja meg az alábbiakat:</span>
															<span class="ru">Пожалуйста, следуйте данным указаниям для возвращения в обычный режим:</span>
																		</h2>
					<ul>
													<li>
																	<span class="en">
										Clear the cookies in your browser for this site.
									</span>
																	<span class="de">
										Löschen sie die Cookies in ihrem Browser
									</span>
																	<span class="hu">
										Törölje a sütiket a böngészőjében!
									</span>
																	<span class="ru">
										Очистите cookie-файлы Вашего браузера для этого сайта.
									</span>
															</li>
													<li>
																	<span class="en">
										Check for any <strong>updates</strong> for your browser.
									</span>
																	<span class="de">
										Laden sie eine <strong>neuere Version</strong> ihres Browsers runter.
									</span>
																	<span class="hu">
										<strong>Frissítse a böngészőjét</strong> a legfrissebb verzióra.
									</span>
																	<span class="ru">
										Проверьте для <strong>обновлений Вашего браузера</strong>.
									</span>
															</li>
													<li>
																	<span class="en">
										<a href="/" onclick="window.history.back();return false;">Go back</a> and try again.
									</span>
																	<span class="de">
										<a href="/" onclick="window.history.back();return false;">Gehen sie zurück</a> und versuchen sie es noch einmal.
									</span>
																	<span class="hu">
										<a href="/" onclick="window.history.back();return false;">Menjen vissza</a> és próbálja újra.
									</span>
																	<span class="ru">
										<a href="/" onclick="window.history.back();return false;">Вернитесь</a> и попытайтесь снова.
									</span>
															</li>
													<li>
																	<span class="en">
										Go to our <a href="/">Homepage</a> and try again from there.
									</span>
																	<span class="de">
										Gehen sie zu unserer <a href="/">Homepage</a> und versuchen sie es von da erneut.
									</span>
																	<span class="hu">
										Térjen vissza a <a href="/">kezdőlapra</a> és próbálja újra onnan.
									</span>
																	<span class="ru">
										Вернитесь на <a href="/">домашнюю страницу</a> и попытайтесь снова.
									</span>
															</li>
											</ul>
							</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var languages = ["en","de","hu","ru"];

	function switchLanguage(language) {
		if (languages.indexOf(language) !== false) {
			document.documentElement.className = 'locale-' + language;
			document.title = document.getElementById('title-' + language).innerHTML;
		}
	}

	function getLanguageEventHandler(language) {
		return function (e) {
			var event;
			if (!e) {
				event = window.event;
			} else {
				event = e;
			}

			event.stopPropagation();
			event.preventDefault();

			switchLanguage(language);
		}
	}

	function showFlags() {
		if (document.getElementById('locale-flags')) {
			document.getElementById('locale-flags').style.display = 'block';
			for (var i = 0; i < languages.length; i++) {
				var handler = getLanguageEventHandler(languages[i]);
				var element = document.getElementById('set-locale-' + languages[i]);

				if (element.addEventListener) {
					element.addEventListener('click', handler, false);
				} else if (element.attachEvent) {
					element.attachEvent('onclick', handler);
				}
			}
		}
	}

	if (navigator.language) {
		var locale = (navigator.language || navigator.userLanguage).replace(/-.*/,'');
		switchLanguage(locale);
		showFlags();
	}
</script>
</body>
</html>
