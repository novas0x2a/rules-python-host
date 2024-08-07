#!/usr/bin/env python3

import datetime
import sys

import pytest


def now() -> datetime:
    return datetime.datetime.now(tz=datetime.UTC)


if __name__ == "__main__":
    print("TEST RUNNER       START", now())
    code = pytest.main(sys.argv[1:])
    print("TEST RUNNER PYTEST DONE", now())
    try:
        sys.exit(code)
    finally:
        print("TEST RUNNER        DONE", now())
