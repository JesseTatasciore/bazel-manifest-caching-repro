# Repro Instructions

This bug can be encountered using a target that outputs a `runfiles_manifest` and contains a source file as an input. In this case, an absolute path to the source file will be stamped into the `runfiles_manifest`. However, if we run 2 builds from 2 different clones of the same repo, on the same commit, with `output_user_root` and `output_base` set to the same paths on both builds, then the `runfiles_manifest` will be incorrectly cached for the second clone / build. The `runfiles_manifest` on the second clone / build will contain a reference to the absolute path of the inputted source file located in the first clone.

Running `./bazel_repro.sh` you can see that
```
.../test/test1/bazel-manifest-caching-repro/hello_world.sh
```
is seen on both both builds even though it should be 
```
.../test/test2/bazel-manifest-caching-repro/hello_world.sh
```
on the second build. 