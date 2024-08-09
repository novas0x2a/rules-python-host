load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_binary")
load("@bazel_skylib//rules:native_binary.bzl", "native_test")
load("@rules_python//python:defs.bzl", "py_binary")

def py_host_binary(name, **kwargs):
    py_binary(name = name + ".input", **kwargs)
    platform_transition_binary(
        name = name,
        binary = name + ".input",
        target_platform = "@platforms//host",
        testonly = kwargs.get("testonly", False),
    )

def py_host_test_only(name, binary, **kwargs):
    data = kwargs.pop("data", []) + \
           kwargs.pop("deps", []) + \
           kwargs.pop("srcs", [])

    kwargs["data"] = data
    kwargs.pop("main", None)
    kwargs.pop("env", None)
    kwargs.pop("python_version", None)
    kwargs.pop("srcs_version", None)

    native_test(
        name = name,
        out = name + ".out",
        src = binary,
        **kwargs
    )

_BIN_ATTRS = [
    "args",
    "data",
    "deps",
    "main",
    "srcs",
    "tags",
    "visibility",
]

def py_host_test(name, **kwargs):
    bin_attrs = {
        i: kwargs[i]
        for i in _BIN_ATTRS
        if i in kwargs
    }

    py_host_binary(name + ".bin", **bin_attrs)
    py_host_test_only(name, binary = name + ".bin", **kwargs)
