all: switch link

.PHONY: apply
switch:
	home-manager switch

.PHONY: link
link:
	stow -R -v . --ignore "Makefile"

