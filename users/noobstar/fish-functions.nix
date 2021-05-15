{
  "proj" = {
    description = "Navigate to a project folder.";
    argumentNames = "project";
    wraps = "cd";
    body = ''
      if test -n "$project"
        cd $HOME/Projects/$project
      else
        cd $HOME/Projects
      end
    '';
  };
  "sch" = {
    description = "Navigate to a school folder.";
    argumentNames = "folder";
    wraps = "cd";
    body = ''
      set base /data/School

      if test -z "$folder"
        cd $base
        return 0
      end

      switch (date | cut -d' ' -f3)
      case Aug Sep Oct Nov Dec
        set semester "Fall"
      case Jan Feb Mar Apr May
        set semester "Spring"
      case Jun Jul
        set semester "Summer"
      case '*'
        echo "Invalid month: $month"
        return 1
      end

      set year (date | cut -d' ' -f4)

      if test -d "$base/$year/$semester/$folder"
        cd "$base/$year/$semester/$folder"
        return 0
      end

      set path (fd "^$folder\$" --type d $base)

      if test (count $path) -eq 1
        cd "$path"
        return 0
      end

      if test (count $path) -gt 1
        set path (string join "
      " $path | sort -n)

        echo "Found" (count $path) "folders:"
        for i in (seq (count $path))
          set cur $path[$i]
          echo "($i)" "$cur" "($i)"
        end

        read --prompt-str="Enter a number (default 1): " choice
        
        if test -z (string trim "$choice")
          set choice 1
        end

        set path $path[$choice]

        cd "$path"
        
        return 0
      end

      echo "Could not find $folder."
      return 1
    '';
  };
}