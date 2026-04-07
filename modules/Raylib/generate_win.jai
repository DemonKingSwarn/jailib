#import "Basic";
#import "Compiler";
#import "Bindings_Generator";

#run build();

build :: () {
  set_build_options_dc(.{do_output = false});

  opts: Generate_Bindings_Options;
  //array_add(*opts.library_search_paths, "raylib-5.5_linux_amd64/lib");
  array_add(*opts.libraries, .{filename="raylib-5.5_win64_mingw-w64/lib/libraylib", identifier = "raylib"});
  array_add(*opts.source_files, 
    "raylib-5.5_win64_mingw-w64/include/raylib.h",
    "raylib-5.5_win64_mingw-w64/include/raymath.h");

  generate_bindings(opts, "windows.jai");

}
