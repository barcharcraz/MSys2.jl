using BinDeps

arch_name = "msys2-x86_64-latest.tar.xz"
depsdir = Pkg.dir("MSys2", "deps")
downloadsdir = joinpath(depsdir, "download")
mkpath(downloadsdir)
download(joinpath("http://repo.msys2.org/distrib", arch_name),
          joinpath(downloadsdir, arch_name))
(name, ext, ext2) = BinDeps.splittarpath(arch_name)
run(unpack_cmd(joinpath(downloadsdir, arch_name), depsdir, ext, ext2))
using MSys2
MSys2.update()
MSys2.install("pacman")
MSys2.upgrade()
MSys2.upgrade()
