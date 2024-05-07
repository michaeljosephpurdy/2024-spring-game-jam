all:
	love ./

images:
	aseprite -b --layer "3" assets/player.aseprite --save-as assets/player-3.png
	aseprite -b --layer "4" assets/player.aseprite --save-as assets/player-4.png
	aseprite -b --layer "5" assets/player.aseprite --save-as assets/player-5.png
	aseprite -b --layer "6" assets/player.aseprite --save-as assets/player-6.png
	aseprite -b --layer "7" assets/player.aseprite --save-as assets/player-7.png
	aseprite -b --layer "8" assets/player.aseprite --save-as assets/player-8.png
	aseprite -b --layer "3" assets/gate.aseprite --save-as assets/gate-3.png
	aseprite -b --layer "4" assets/gate.aseprite --save-as assets/gate-4.png
	aseprite -b --layer "5" assets/gate.aseprite --save-as assets/gate-5.png
	aseprite -b --layer "6" assets/gate.aseprite --save-as assets/gate-6.png
	aseprite -b --layer "7" assets/gate.aseprite --save-as assets/gate-7.png
	aseprite -b --layer "8" assets/gate.aseprite --save-as assets/gate-8.png
	aseprite -b --layer "solid" assets/platforms.aseprite --save-as assets/solid-platform.png

serve:
	rm -rf makelove-build
	makelove lovejs
	unzip -o "makelove-build/lovejs/2024-spring-game-jam-lovejs" -d makelove-build/html/
	echo "http://localhost:8000/makelove-build/html/2024-spring-game-jam/"
	python3 -m http.server
