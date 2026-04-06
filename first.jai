#import "Basic";
#import "Compiler";

#run {
  set_build_options_dc(.{do_output = false});

  w := compiler_create_workspace("Raylib");

  options := get_build_options(w);
  import_path: [..]string;
  array_add(*import_path, "./raylib-5.5_linux_amd64/lib");
  for options.import_path array_add(*import_path, it);
  options.import_path = import_path;
  options.output_executable_name = "main";
  set_build_options(options, w);

  add_build_file("main.jai", w);
}
