using BinDeps
import BinDeps: PackageManager, can_use, package_available,
        available_version, generate_steps, LibraryDependency, pkg_name,
        libdir
type Mingw64 <: PackageManager
  package :: AbstractString
  Mingw64(package) = new("mingw-w64-x86_64-" * package)
end

can_use(::Type{Mingw64}) = OS_NAME == :Windows
package_available(m :: Mingw64) = can_use(Mingw64) && exists(m.package)
available_version(m :: Mingw64) = get(info(m.package), "Version")
pkg_name(m :: Mingw64) = m.package
libdir(m :: Mingw64, dep) = joinpath(Pkg.dir("MSys2"), "deps", "msys64", "mingw64", "bin")

function generate_steps(dep :: LibraryDependency, m :: Mingw64, opts)
  () -> install(m.package)
end
