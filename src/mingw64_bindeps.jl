using BinDeps
import BinDeps: PackageManager, can_use, package_available, available_version,
    libdir, generate_steps, LibraryDependency, provider, provides, pkg_name
type Mingw64 <: PackageManager
  package :: AbstractString
  Mingw64(package :: AbstractString) = new("mingw-w64-x86_64-" * package)
end

can_use(::Type{Mingw64}) = OS_NAME == :Windows
package_available(m :: Mingw64) = can_use(Mingw64) && exists(m.package)
available_version(m :: Mingw64) = get(info(m.package), "Version")
pkg_name(m :: Mingw64) = m.package
libdir(m :: Mingw64, dep) = joinpath(Pkg.dir("MSys2"), "deps", "msys64", "mingw64", "bin")

function generate_steps(dep :: LibraryDependency, m :: Mingw64, opts)
  if get(opts,:force_rebuild,false)
    error("Will not force yum to rebuild dependency \"$(dep.name)\".\n"*
        "Please make any necessary adjustments manually (This might just be a version upgrade)")
  end
  () -> install(m.package)
end
