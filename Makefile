.PHONY: serve c clean

serve: c
	uv run zensical serve

c clean:
	rm -rf site