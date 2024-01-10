all: generate

generate:
	dart run build_runner build --delete-conflicting-outputs

server:
	json-server -w db.json -p 8000