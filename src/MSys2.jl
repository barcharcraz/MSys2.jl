module MSys2
using IniFile
import Base: *, spawn, ProcessChain, StdIOSet, Callback
export *, msys
# package code goes here
const bash_dir = joinpath(Pkg.dir("MSys2"), "deps", "msys64", "usr", "bin")
const prefix = "mingw-w64-x86_64-"
type msys <: Base.AbstractCmd
  cmd :: Cmd
end
function *(::Type{msys}, cmd :: Cmd)
  msys(cmd)
end

function Base.spawn(cmd::msys, stdios::Base.StdIOSet, exitcb::Callback, closecb::Callback; chain::Nullable{ProcessChain}=Nullable{ProcessChain}())
  first_part = `$bash_dir\\bash --login -c`
  c = Cmd(ByteString[first_part.exec; join(cmd.cmd.exec, " ")])
  Base.spawn(c, stdios, exitcb, closecb)
end



function update()
  run(msys`pacman -Sy`)
end
function upgrade()
  run(msys`pacman -Syuu --noconfirm`)
end
function search_call(package :: AbstractString)

  readall(msys`pacman -Ss $(package)`)
end
function search(package :: AbstractString)
  raw = search_call(package)
  lines = split(raw, "\n")
  descs = filter(n -> startswith(n, " "), lines)
  names = filter(n -> !startswith(n, " ") && n != "", lines)
  map!(strip, descs)
  names
end
function exists(package :: AbstractString)
  success(msys`pacman -Si $(package)`)
end
function info(package :: AbstractString)
  raw = readall(msys`pacman -Si $(package)`)
  read(Inifile(), IOBuffer(raw))
end
function install(package :: AbstractString)
  run(msys`pacman -S --noconfirm $package`)
end

include("mingw64_bindeps.jl")

end # module
