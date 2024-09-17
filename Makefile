.DEFAULT_GOAL := publish

EXE=

RUNTIME=
OUTPUT_DIR=artifacts/Sapling/

ifeq ($(OS),Windows_NT)
	ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
		RUNTIME=win-x64
	else
		RUNTIME=win-x86
	endif
else
	UNAME_S := $(shell uname -s)
	UNAME_P := $(shell uname -p)
	ifeq ($(UNAME_S),Linux)
		RUNTIME=linux-x64
		ifneq ($(filter aarch64%,$(UNAME_P)),)
			RUNTIME=linux-arm64
		else ifneq ($(filter armv8%,$(UNAME_P)),)
			RUNTIME=linux-arm64
		else ifneq ($(filter arm%,$(UNAME_P)),)
			RUNTIME=linux-arm
		endif
	else ifneq ($(filter arm%,$(UNAME_P)),)
		RUNTIME=osx-arm64
	else
		RUNTIME=osx-x64
	endif
endif

ifndef RUNTIME
	$(error RUNTIME is not set for $(OS) $(UNAME_S) $(UNAME_P), please fill an issue in https://github.com/timmoth/Sapling/issues/new/choose)
endif

ifdef EXE
	OUTPUT_DIR=./
endif

build:
	dotnet build -c Release

test:
	dotnet test -c Release

publish:
	dotnet publish Sapling/Sapling.csproj -c Release --runtime ${RUNTIME} --self-contained /p:Optimized=true /p:DeterministicBuild=true /p:ExecutableName=$(EXE) -o ${OUTPUT_DIR}

run:
	dotnet run --project Sapling/Sapling.csproj -c Release --runtime ${RUNTIME}
