using BinDeps

arch_name = "msys2-x86_64-latest.tar.xz"
depsdir = Pkg.dir("MSys2", "deps")
downloadsdir = joinpath(depsdir, "download")
mkpath(downloadsdir)
download(joinpath("http://repo.msys2.org/distrib", arch_name),
          joinpath(downloadsdir, arch_name))
(name, ext, ext2) = BinDeps.splittarpath(arch_name)
run(unpack_cmd(joinpath(downloadsdir, arch_name), depsdir, ext, ext2))
cmdpath = joinpath(depsdir, "msys64", "usr", "bin", "bash.exe")
using MSys2
MSys2.upgrade()
