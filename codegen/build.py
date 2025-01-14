"""
Handles build of DataContainer:
https://github.com/schombert/DataContainer
"""
import os
import sys
import platform
import time
import subprocess
from pathlib import Path
from shutil import copyfile, move

COMPILE_DCON_GEN = sys.argv[1]=="true"
COMPILE_LUA_GEN = sys.argv[2]=="true"

CODEGEN_DCON = sys.argv[3]=="true"
CODEGEN_LUA = sys.argv[4]=="true"

SYSTEM = platform.system()
MACHINE = platform.machine()

print("platform",SYSTEM, MACHINE)

root = Path().absolute()

codegen_path = root.joinpath("codegen")

description_path = \
    codegen_path.joinpath("dcon").joinpath("sote.txt")

additional_types_header = \
    codegen_path.joinpath("dcon").joinpath("sote_types.hpp")
additional_functions_source = \
    codegen_path.joinpath("dcon").joinpath("sote_functions.cpp")
additional_functions_header = \
    codegen_path.joinpath("dcon").joinpath("sote_functions.hpp")

generation_folder = root.joinpath("build")
repo_folder = generation_folder.joinpath("DataContainer")

dcon_generator_folder = repo_folder.joinpath("DataContainerGenerator")
dll_generator_folder = repo_folder.joinpath("LuaDLLGenerator")


common_include = repo_folder.joinpath("CommonIncludes")

description_destination = \
    generation_folder.joinpath("objs.txt")

additional_types_destination = \
    generation_folder.joinpath("sote_types.hpp")
additional_functions_src_destination = \
    generation_folder.joinpath("sote_functions.cpp")
additional_functions_header_destination = \
    generation_folder.joinpath("sote_functions.hpp")

generator_name = "DataContainerGenerator"
dll_generator_name = "LuaDLLGenerator"

if os == 'nt':
    generator_name += ".exe"
    dll_generator_name += ".exe"

system_path = generation_folder.joinpath(SYSTEM).joinpath(MACHINE)
os.makedirs(system_path, exist_ok=True)

generator_exe = \
    system_path.joinpath(generator_name)

dll_generator_exe = \
    system_path.joinpath(dll_generator_name)

copyfile(description_path, description_destination)
copyfile(additional_types_header, additional_types_destination)
copyfile(additional_functions_source, additional_functions_src_destination)
copyfile(additional_functions_header, additional_functions_header_destination)


if COMPILE_DCON_GEN:
    print("Compiling DataContainerGenerator...")
    now = time.time()
    try:
        subprocess.run(subprocess.list2cmdline([ \
            "clang++",
            "-std=c++20",
            dcon_generator_folder.joinpath("code_fragments.cpp"),
            dcon_generator_folder.joinpath("DataContainerGenerator.cpp"),
            dcon_generator_folder.joinpath("object_member_fragments.cpp"),
            dcon_generator_folder.joinpath("parsing.cpp"),
            dcon_generator_folder.joinpath("query_fragments.cpp"),
            dcon_generator_folder.joinpath("serialize_fragments.cpp"),
            "-o", "a.exe",
        ]), check=True, shell=True)
    except subprocess.CalledProcessError as command_line_error:
        print("executed command:")
        print(subprocess.list2cmdline(command_line_error.cmd))
        raise
    move("a.exe", generator_exe)
    print("DataContainerGenerator took " + str(time.time() - now) + " seconds to compile.")

if CODEGEN_DCON:
    print("Running DataContainerGenerator...")
    now = time.time()
    subprocess.run([generator_exe, description_destination], check=True)
    print("DataContainerGenerator took " + str(time.time() - now) + " seconds to run.")

if COMPILE_LUA_GEN:
    print("Compiling LuaDLLGenerator...")
    now = time.time()
    subprocess.run(subprocess.list2cmdline([ \
        "clang++",
        "-std=c++20",
        dll_generator_folder.joinpath("LuaDLLGenerator.cpp"),
        dll_generator_folder.joinpath("parsing.cpp"),
        "-o", "a.exe",
    ]), check=True, shell=True)
    move("a.exe", dll_generator_exe)
    print("LuaDLLGenerator took " + str(time.time() - now) + " seconds to compile.")

if CODEGEN_LUA:
    print("Running LuaDLLGenerator...")
    now = time.time()
    subprocess.run([dll_generator_exe, description_destination], check=True)
    print("LuaDLLGenerator took " + str(time.time() - now) + " seconds to run.")

# compile dll itself
for file in os.listdir(common_include):
    copyfile(common_include.joinpath(file), generation_folder.joinpath(file))

dll_folder = root.joinpath("lib").joinpath(SYSTEM).joinpath(MACHINE)
os.makedirs(dll_folder, exist_ok = True)

O2 = "-inline -mldst-motion -gvn -elim-avail-extern -slp-vectorizer -constmerge".split()
O3 = "-callsite-splitting -argpromotion"

# COMPILATION_FLAGS = [
#     # O0 part
#     "-tti", "-verify", "-ee-instrument", "-targetlibinfo",
#     "-assumption-cache-tracker", "-profile-summary-info",
#     "-forceattrs", "-basiccg", "-always-inline", "-barrier"
#     # O1 part
#     "-tbaa", "-scoped-noalias", "-inferattrs", "-ipsccp", "-called-value-propagation",
#     "-globalopt", "-domtree", "-mem2reg", "-deadargelim", "-basicaa", "-aa",
#     "-loops", "-lazy-branch-prob", "-lazy-block-freq", "-opt-remark-emitter",
#     "-instcombine", "-simplifycfg",
#     "-globals-aa", "-prune-eh",
#     "-functionattrs", "-sroa", "-memoryssa",
#     "-early-cse-memssa", "-speculative-execution", "-lazy-value-info",
#     "-jump-threading", "-correlated-propagation", "-libcalls-shrinkwrap",
#     "-branch-prob", "-block-freq", "-pgo-memop-opt", "-tailcallelim",
#     "-reassociate", "-loop-simplify", "-lcssa-verification", "-lcssa",
#     "-scalar-evolution",
#     # "-loop-rotate", "-licm", # they are slow because of the giant serialisation loop
#     "-loop-unswitch", "-indvars", "-loop-idiom", "-loop-deletion", "-loop-unroll",
#     "-memdep", "-memcpyopt", "sccp", "demanded-bits", "bdce", "dse",
#     "postdomtree", "adce", "barrier", "rpo-functionattrs",
#     "globaldce", "float2int", "loop-accesses", "loop-distribute",
#     "loop-vectorize", "loop-load-elim", "alignment-from-assumptions",
#     "strip-dead-prototypes", "loop-sink", "instsimplify", "div-rem-pairs",
#     "verify", "ee-instrument", "early-cse", "lower-expect"
#     # O2 part
#     # todo
#     # O3 part
#     # todo
# ]

if os.name == 'nt':
    print("Compiling dll...")
    now = time.time()
    subprocess.run(subprocess.list2cmdline([ \
        "clang++",
        "-O3",
        # "-O1",
        # "-O0"
        ] \
        +["-std=c++20",
        # "-msse4.1",
        "-shared",
        "-mavx2",
        # "-ftime-report",
        # "-DDCON_LUADLL_EXPORTS",
        generation_folder.joinpath("lua_objs.cpp"),
        generation_folder.joinpath("common_types.cpp"),
        additional_functions_src_destination,
        "-o", "dcon.dll",
    ]), check=True, shell=True)


    print("DLL took " + str(time.time() - now) + " seconds")

    time.sleep(0.1)

    # dire times require dire solutions
    for i in range(10):
        try:
            move("./dcon.dll", dll_folder.joinpath("dcon.dll"))
            move("./dcon.exp", dll_folder.joinpath("dcon.exp"))
            move("./dcon.lib", dll_folder.joinpath("dcon.lib"))
            break
        except PermissionError:
            time.sleep(0.5)
else:
    print("Compiling linux library...")
    now = time.time()

    subprocess.run(" ".join(["clang++", "-O3",
                                            "-std=c++20", "-msse4.1", "-shared", "-fdeclspec",
                                            "-mavx2", "-fPIC",
                                            ("-L./lib/"+SYSTEM+"/"+MACHINE),
                                            ("-Wl,-R./lib/"+SYSTEM+"/"+MACHINE),
                                            "-DPREFER_ONE_TBB", f'-I{str(generation_folder.joinpath(SYSTEM).joinpath(MACHINE).joinpath("include"))}',
                                            str(generation_folder.joinpath("lua_objs.cpp")),
                                            str(generation_folder.joinpath("common_types.cpp")),
                                            str(additional_functions_src_destination),
                                            "-o", "dcon.so", "-ltbb",
                                            #str(codegen_path.joinpath("dll").joinpath("linux").joinpath("libtbb.so")),
                                            #str(codegen_path.joinpath("dll").joinpath("linux").joinpath("libtbb.so.12")),

                             ]),
                   check = True, shell = True)

    print("Linux Library took " + str(time.time() - now) + " seconds to compile.")
    move("./dcon.so", dll_folder.joinpath("dcon.so"))

