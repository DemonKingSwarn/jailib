#import "Basic";
#import "Compiler";
#import "Bindings_Generator";

#run build();

build :: () {
  set_build_options_dc(.{do_output = false});

  opts: Generate_Bindings_Options;
  array_add(*opts.library_search_paths, "raylib-5.5_linux_amd64/lib");
  array_add(*opts.libraries, .{filename="libraylib"});
  array_add(*opts.source_files, 
    "raylib-5.5_linux_amd64/include/raylib.h",
    "raylib-5.5_linux_amd64/include/raymath.h");

  generate_bindings(opts, "raylib.jai");

  w := compiler_create_workspace("Raylib");

  options := get_build_options(w);
  
  options.output_executable_name = "main";
  set_build_options(options, w);

  add_build_file("main.jai", w);
}
