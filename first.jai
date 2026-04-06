#import "Basic";
#import "Compiler";

#run {
  set_build_options_dc(.{do_output = false});

  w := compiler_create_workspace("Raylib");

  options := get_build_options(w);
  
  options.output_executable_name = "main";
  set_build_options(options, w);

  add_build_file("main.jai", w);
}
