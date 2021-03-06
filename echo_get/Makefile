# Copyright 2012 Erlware, LLC. All Rights Reserved.
#
# BSD License see COPYING

ERL = $(shell which erl)
ERL_VER = $(shell erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell)

ERLFLAGS= -pa $(CURDIR)/.eunit -pa $(CURDIR)/ebin -pa $(CURDIR)/deps/**/ebin

REBAR=$(shell which rebar)

ifeq ($(REBAR),)
$(error "Rebar not available on this system")
endif

URI_PLT=$(CURDIR)/.uri_plt

.PHONY: all compile doc clean test shell distclean pdf get-deps rebuild dialyzer typer release

all: compile doc test

deps:
	$(REBAR) get-deps compile

get-deps:
	$(REBAR) get-deps compile

compile: deps
	$(REBAR) skip_deps=true compile

doc: compile
	- $(REBAR) skip_deps=true doc

test: compile
	$(REBAR) skip_deps=true eunit

$(URI_PLT).$(ERL_VER).erts:
	@echo Building local plt at $(URI_PLT).$(ERL_VER).base
	@echo

	- dialyzer --fullpath --verbose --output_plt $(URI_PLT).$(ERL_VER).base --build_plt \
	   --apps erts

$(URI_PLT).$(ERL_VER).kernel:$(URI_PLT).$(ERL_VER).erts
	@echo Building local plt at $(URI_PLT).$(ERL_VER).base
	@echo
	- dialyzer --fullpath --verbose --output_plt $(URI_PLT).$(ERL_VER).base --build_plt \
	   --apps kernel

$(URI_PLT).$(ERL_VER).base:$(URI_PLT).$(ERL_VER).kernel
	@echo Building local plt at $(URI_PLT).$(ERL_VER).base
	@echo
	- dialyzer --fullpath --verbose --output_plt $(URI_PLT).$(ERL_VER).base --build_plt \
	   --apps stdlib

$(URI_PLT).$(ERL_VER): $(URI_PLT).$(ERL_VER).base
	@echo Building local plt at $(URI_PLT).$(ERL_VER)
	@echo
	- dialyzer --fullpath --verbose --output_plt $(URI_PLT).$(ERL_VER) --add_to_plt --plt $(URI_PLT).$(ERL_VER).base \
	   --apps eunit -r deps

dialyzer: $(URI_PLT).$(ERL_VER)
	dialyzer --fullpath --plt $(URI_PLT).$(ERL_VER) -Wrace_conditions -r ./ebin

typer: $(URI_PLT).$(ERL_VER)
	typer --plt $(URI_PLT).$(ERL_VER) -r ./src

shell: compile
# You often want *rebuilt* rebar tests to be available to the
# shell you have to call eunit (to get the tests
# rebuilt). However, eunit runs the tests, which probably
# fails (thats probably why You want them in the shell). This
# runs eunit but tells make to ignore the result.
	- @$(REBAR) skip_deps=true eunit
	@$(ERL) $(ERLFLAGS)

clean:
	$(REBAR) skip_deps=true clean
	rm -rf $(CURDIR)/doc/*.html
	rm -rf $(CURDIR)/doc/*.css
	rm -rf $(CURDIR)/doc/*.png
	rm -rf $(CURDIR)/doc/edoc-info
	rm -rf $(CURDIR)/_rel
	rm -rf $(CURDIR)/rel

distclean: clean
	rm -rf $(URI_PLT).$(ERL_VER)
	rm -rvf $(CURDIR)/deps

rebuild: distclean all

release: compile test
	rebar release
